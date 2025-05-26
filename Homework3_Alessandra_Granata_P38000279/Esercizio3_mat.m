clc
clear all 
close all
load('ws_homework_3_2025.mat');

% Parametri
mass = 1.5;
g = 9.81;
Ib = diag([1.2416 1.2416 2*1.2416]);
Ts = 0.001;
r = 8;



%% Estrazione segnali dai campi delle struct
att     = attitude.signals.values;
att_dot = attitude_vel.signals.values;
lin_vel = linear_vel.signals.values;
thrust  = thrust.signals.values;
tau_b   = tau.signals.values;
t       = attitude.time;

N = length(t); %numero di campioni su cui iterare

%% Filtro Butterworth
[b, a] = butter(r, 1 , 'low', 's');
K = zeros(r, 1);
prod = 1;
for i = 1:r
    K(i) = a(i+1) / prod; 
    prod = prod * K(i);
end
K = flip(K); % Inverte l'ordine per usarli nella ricorsione dell'estimatore

%% Inizializzazione
gamma = zeros(6, N, r);
hat_w_e= zeros(6, N);
q = zeros(6, N);
e3 = [0; 0; 1];

for k = 1:N-1
    % Estrai valori attuali
    phi = att(k,1); theta = att(k,2); psi = att(k,3);
    phi_dot = att_dot(k,1); theta_dot = att_dot(k,2); psi_dot = att_dot(k,3);

    % Matrice Q
    Q = [1 0 -sin(theta);
         0 cos(phi) cos(theta)*sin(phi);
         0 -sin(phi) cos(theta)*cos(phi)];
    Q_T = Q';

    % Derivata di Q
    Qdot = [0 0 -cos(theta)*theta_dot;
            0 -sin(phi)*phi_dot, -sin(theta)*sin(phi)*theta_dot + cos(theta)*cos(phi)*phi_dot;
            0 -cos(phi)*phi_dot, -sin(theta)*cos(phi)*theta_dot - cos(theta)*sin(phi)*phi_dot];

    % Matrice di rotazione
    Rb = eul2rotm([psi theta phi], 'ZYX');

    % Skew(Q * etadot)
    v = Q * att_dot(k,:)';
    Skew = [ 0 -v(3) v(2);
             v(3) 0 -v(1);
            -v(2) v(1) 0 ];

    % Matrici dinamiche
    C = Q_T * Skew * Ib * Q + Q_T * Ib * Qdot;
    M = Q_T * Ib * Q;

    % Quantità di moto
    lin_vel_k1   = lin_vel(k+1, :)';       % Velocità lineare (3x1)
    att_dot_k1   = att_dot(k+1, :)';       % Velocità angolare (3x1)
    
    q_lin = mass * lin_vel_k1;             % Momento lineare (3x1)
    q_ang = M * att_dot_k1;                % Momento angolare (3x1)
    
    q(:,k+1) = [q_lin; q_ang];             % Quantità di moto totale (6x1)


    %% Ricorsione dell’estimatore
    for i = 1:r
        if i == 1
            gamma(:,k+1,1) = gamma(:,k,1) + ...
                K(1)*( (q(:,k+1) - q(:,k)) - Ts * ...
                (hat_w_e(:,k) + ...
                [mass*g*e3 - thrust(k)*Rb*e3;
                 C' * att_dot(k,:)' + Q_T * tau_b(k,:)']));
        else
            gamma(:,k+1,i) = gamma(:,k,i) + ...
                K(i) * Ts * (-hat_w_e(:,k) + gamma(:,k,i-1));
        end
    end

    % Stima finale
    hat_w_e(:,k+1) = gamma(:,k+1,r);
end

%% Output stimato
f_hat_e = hat_w_e(1:3,:);
tau_hat_e = hat_w_e(4:6,:);


%% error over time
fe_true= [1; 1; 0]; 
tau_e_true=[0; 0; -0.4];
real_wrench = repmat([fe_true; tau_e_true], 1, N);
error = hat_w_e(:, 1:N) - real_wrench;
norm_error = vecnorm(error);

% Mean error norm
disp(['Mean error norm: ', num2str(mean(norm_error))]);

%% Plot estimation error for x, y, yaw 
set(0, 'DefaultTextInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')
f_err = figure('Renderer', 'painters', 'Position', [10 10 900 2*350]);

selected_indices = [1, 2, 6]; % force x, force y, yaw torque
labels = {'$\hat{f}_x - f_x$ (N)', '$\hat{f}_y - f_y$ (N)', '$\hat{\tau}_z - \tau_z$ (Nm)'};
colors = [
    0, 0, 1;        
    1, 0, 0;  
    0, 1, 0;
];

for i = 1:3
    subplot(3,1,i);
    hold on;
    plot(t, error(selected_indices(i), :), 'Color', colors(i,:), 'LineWidth', 1.5);
    yline(0, '--', 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1);
    set(gca, 'FontSize', 12);
    xlabel('t (s)', 'Interpreter', 'latex');
    ylabel(labels{i}, 'Interpreter', 'latex');
    xlim([min(t) max(t)]);
    grid on;
    box on;
    hold off;
end

sgtitle('Estimation Errors: $\hat{f}_x$, $\hat{f}_y$, $\hat{\tau}_z$', 'Interpreter', 'latex');

% Save figure
exportgraphics(f_err, 'plots_3/estimation_errors_r8.pdf');


%% Real Mass
m_bar= mass + f_hat_e(3,N)/g;
disp(['Real mass: ', num2str(m_bar), ' kg']);
%% Plots
set(0, 'DefaultTextInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')
f = figure('Renderer', 'painters', 'Position', [10 10 900 2*350]);

% Force X
subplot(3,1,1)
hold on
plot(t, f_hat_e(1,:), 'LineWidth', 1.5, 'Color', [0, 0.2, 0.8]) 
plot(t, fe_true(1)*ones(size(t)), '--', 'LineWidth', 1.5, 'Color', [0.85, 0.35, 0]) 
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{f}_x$ (N)', 'Interpreter', 'latex')
legend('Estimated', 'True', 'Interpreter', 'latex', 'Location','southeast')
xlim([min(t) max(t)])
ylim([min(f_hat_e(1,:)) max(f_hat_e(1,:))])
grid on;
box on;
hold off

% Force Y
subplot(3,1,2)
hold on
plot(t, f_hat_e(2,:), 'LineWidth', 1.5, 'Color', [0, 0.6, 0.2]) 
plot(t, fe_true(2)*ones(size(t)), '--', 'LineWidth', 1.5, 'Color', [0.85, 0.35, 0]) 
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{f}_y$ (N)', 'Interpreter', 'latex')
legend('Estimated', 'True', 'Interpreter', 'latex', 'Location','southeast')
xlim([min(t) max(t)])
ylim([min(f_hat_e(2,:)) max(f_hat_e(2,:))])
grid on;
box on;
hold off

% Torque Z
subplot(3,1,3)
hold on
plot(t, tau_hat_e(3,:), 'LineWidth', 1.5, 'Color',  [0.0, 0.5, 0.7]) 
plot(t, -0.4*ones(size(t)), '--', 'LineWidth', 1.5, 'Color', [0.85, 0.35, 0]) 
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{\tau}_z$ (Nm)', 'Interpreter', 'latex')
legend('Estimated', 'True', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(t) max(t)])
ylim([min(tau_hat_e(3,:))-0.05 max(tau_hat_e(3,:))])
grid on;
box on;
hold off

% Save figure
sgtitle('Estimated Wrench', 'Interpreter', 'latex', 'FontSize', 14)
exportgraphics(f, 'plots_3/External_Wrench_Estimation_r8.pdf');

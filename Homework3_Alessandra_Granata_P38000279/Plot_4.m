close all

% Estrai i dati
time = squeeze(out.err_p.time)';
err_p = squeeze(out.err_p.data)';         % 3 x N
dot_err_p = squeeze(out.dot_err_p.data)'; % 3 x N

%% Position Error 
f = figure('Renderer','painters','Position',[10 10 900 700]);
hold on
plot(time, err_p(1,:), '-', 'Color', [0, 0, 1], 'LineWidth', 1.5);        
plot(time, err_p(2,:), '--', 'Color', [1, 0, 0], 'LineWidth', 1.5);       
plot(time, err_p(3,:), '-', 'Color', [0,0.6,0], 'LineWidth', 1.5); 
hold off
title('Position Error','FontSize',20)
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Error (m)', 'Interpreter', 'latex')
legend('$e_{p,x}$', '$e_{p,y}$', '$e_{p,z}$', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(f, 'plot_es_4/position_error.pdf');

%% Linear Velocity Error
g = figure('Renderer','painters','Position',[10 10 900 700]);
hold on
plot(time, dot_err_p(1,:), '-', 'Color', [0, 0, 1], 'LineWidth', 1.5);         
plot(time, dot_err_p(2,:), '--', 'Color', [1, 0, 0], 'LineWidth', 1.5);        
plot(time, dot_err_p(3,:), '-', 'Color', [0,0.6,0], 'LineWidth', 1.5);
hold off
title('Linear Velocity Error','FontSize',20)
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Velocity Error (m/s)', 'Interpreter', 'latex')
legend('$\dot{e}_{p,x}$', '$\dot{e}_{p,y}$', '$\dot{e}_{p,z}$', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(g, 'plot_es_4/linear_velocity_error.pdf');

%% Orientation Error

time = squeeze(out.err_R.time)';
err_R = squeeze(out.err_R.data)'; % 3 x N
err_W = squeeze(out.err_W.data)'; % 3 x N
e = figure('Renderer','painters','Position',[10 10 900 700]);
hold on
plot(time, err_R(1,:), '-', 'Color', [0, 0, 1], 'LineWidth', 1.5);         
plot(time, err_R(2,:), '-', 'Color', [1, 0, 0], 'LineWidth', 1.5);        
plot(time, err_R(3,:), '-', 'Color', [0,0.6,0], 'LineWidth', 1.5);
hold off
title('Orientation Error','FontSize',20)
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Error (m)', 'Interpreter', 'latex')
legend('$e_{R,roll}$', '$e_{R,pitch}$', '$e_{R,yaw}$', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(e, 'plot_es_4/orientation_error.pdf');

%% Angular Velocity Error
h = figure('Renderer','painters','Position',[10 10 900 700]);
hold on
plot(time, err_W(1,:), '-', 'Color', [0, 0, 1], 'LineWidth', 1.5);         % Fucsia (x)
plot(time, err_W(2,:), '-', 'Color', [1, 0, 0], 'LineWidth', 1.5);        % Blu tratteggiato (y)
plot(time, err_W(3,:), '-', 'Color', [0,0.6,0], 'LineWidth', 1.5); % Azzurro (z)
hold off
title('Angular Velocity Error','FontSize',20)
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Velocity Error (rad/s)', 'Interpreter', 'latex')
legend('$\dot{e}_{R,roll}$', '$\dot{e}_{R,pitch}$', '$\dot{e}_{R,yaw}$', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(h, 'plot_es_4/angular_velocity_error.pdf');

%% Thrust plot
l = figure('Renderer','painters','Position',[10 10 900 700]);
hold on;
time = squeeze(out.err_R.time)';
u_T = squeeze(out.u_t.data)'; 
plot(time, u_T, '-', 'Color', [0, 0, 1], 'LineWidth', 1.5);
hold off
title('Thrust $u_T$','FontSize',20, 'Interpreter', 'latex') 
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$u_T$ (N)', 'Interpreter', 'latex')       
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(l, 'plot_es_4/thrust.pdf');

%% Tau_b plot
l = figure('Renderer','painters','Position',[10 10 900 700]);
hold on;
time = squeeze(out.err_R.time)';
tau_b = squeeze(out.tau_b.data)'; % 3 x N

plot(time, tau_b(1,:), '-',  'Color', [0, 0, 1], 'LineWidth', 1.5);  
plot(time, tau_b(2,:), '-', 'Color',  [1, 0, 0], 'LineWidth', 1.5); 
plot(time, tau_b(3,:), '-',  'Color', [0, 0.6, 0], 'LineWidth', 1.5); 

hold off
title('Torque $\tau_b$','FontSize',20, 'Interpreter', 'latex')
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\tau_b$~(Nm)', 'Interpreter', 'latex')
legend('$\tau_{b,x}$', '$\tau_{b,y}$', '$\tau_{b,z}$', ...
       'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;

% Esporta la figura
exportgraphics(l, 'plot_es_4/torque_tau_b.pdf');

%% Position

k = figure('Renderer','painters','Position',[10 10 900 700]);
hold on;
time = squeeze(out.pos.time)';
pos = squeeze(out.pos.data)'; % 3 x N

plot(time, pos(1,:), '-',  'Color', [0, 0, 1], 'LineWidth', 1.5);  % Fucsia (x)
plot(time, pos(2,:), '--', 'Color', [1, 0, 0], 'LineWidth', 1.5);  % Blu tratteggiato (y)
plot(time, pos(3,:), '-',  'Color', [0, 0.6, 0], 'LineWidth', 1.5);  % Rosso (z)

hold off
title('Position','FontSize',20, 'Interpreter', 'latex')
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Position (m)', 'Interpreter', 'latex')
legend('$x$', '$y$', '$z$', ...
       'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;

% Esporta la figura
exportgraphics(k, 'plot_es_4/position.pdf');


%% Orientation

x = figure('Renderer','painters','Position',[10 10 900 700]);
hold on;

% Estrai i dati
time = squeeze(out.yaw.time)';
yaw = squeeze(out.yaw.data)'; % 1 x N (presumo)

% Traccia il grafico
plot(time, yaw, '-', 'Color', [0, 0.6, 0], 'LineWidth', 1.5);  % Fucsia

% Personalizza il grafico
title('Yaw Angle','FontSize',20, 'Interpreter', 'latex')
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Yaw~($^\circ$)', 'Interpreter', 'latex')
legend('Yaw Angle', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;

% Esporta la figura
exportgraphics(x, 'plot_es_4/orientation.pdf');

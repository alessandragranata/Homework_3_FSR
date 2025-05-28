close all

time=squeeze(out.posdes.time)';
posdes=squeeze(out.posdes.Data)';
pos=squeeze(out.pos.Data)';
%omegabbdes=squeeze(out.omegabbdes.Data)';
%dotomegabbdes=squeeze(out.dotomegabbdes.Data)';
errp=squeeze(out.errp.Data)';
doterrp=squeeze(out.doterrp.Data)';
eR=squeeze(out.eR.Data)';
eW=squeeze(out.eW.Data)';
uw=squeeze(out.uw.Data)';
alfa=squeeze(out.alfa.Data)';
phi=squeeze(out.phi.Data)';
csi=squeeze(out.csi.Data)';
theta=squeeze(out.theta.Data)';
csides=squeeze(out.csides.Data)';
phides=squeeze(out.phides.Data)';
thetades=squeeze(out.thetades.Data)';



%% Position Error 
f = figure('Renderer','painters','Position',[10 10 900 700]);
hold on
plot(time, errp(1,:), '-', 'Color', [1, 0, 1], 'LineWidth', 1.5); % Fucsia (x)
plot(time, errp(2,:), '--', 'Color', [0, 0, 1], 'LineWidth', 1.5);% Blu tratteggiato (y)
plot(time, errp(3,:), '-', 'Color', [1,0,0], 'LineWidth', 1.5); % Azzurro (z)
hold off
title('Position Error','FontSize',20)
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Error (m)', 'Interpreter', 'latex')
legend('$e_{p,x}$', '$e_{p,y}$', '$e_{p,z}$', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(f, 'plot_es_5/position_error.pdf');

%% linear velocity error
g = figure('Renderer','painters','Position',[10 10 900 700]);
hold on
plot(time, doterrp(1,:), '-', 'Color', [1, 0, 1], 'LineWidth', 1.5);         % Fucsia (x)
plot(time, doterrp(2,:), '--', 'Color', [0, 0, 1], 'LineWidth', 1.5);        % Blu tratteggiato (y)
plot(time, doterrp(3,:), '-', 'Color', [1,0,0], 'LineWidth', 1.5); % Azzurro (z)
hold off
title('Linear Velocity Error','FontSize',20)
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Velocity Error (m/s)', 'Interpreter', 'latex')
legend('$\dot{e}_{p,x}$', '$\dot{e}_{p,y}$', '$\dot{e}_{p,z}$', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(g, 'plot_es_5/linear_velocity_error.pdf');

%% Orientation Error
e = figure('Renderer','painters','Position',[10 10 900 700]);
hold on
plot(time, eR(1,:), '-', 'Color', [1, 0, 1], 'LineWidth', 1.5);         % Fucsia (x)
plot(time, eR(2,:), '-', 'Color', [0, 0, 1], 'LineWidth', 1.5);        % Blu tratteggiato (y)
plot(time, eR(3,:), '-', 'Color', [1,0,0], 'LineWidth', 1.5); % Azzurro (z)
hold off
title('Orientation Error','FontSize',20)
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Error (rad)', 'Interpreter', 'latex')
legend('$e_{R,roll}$', '$e_{R,pitch}$', '$e_{R,yaw}$', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(e, 'plot_es_5/orientation_error.pdf');

%% Angular Velocity Error
h = figure('Renderer','painters','Position',[10 10 900 700]);
hold on
plot(time, eW(1,:), '-', 'Color', [1, 0, 1], 'LineWidth', 1.5);         % Fucsia (x)
plot(time, eW(2,:), '-', 'Color', [0, 0, 1], 'LineWidth', 1.5);        % Blu tratteggiato (y)
plot(time, eW(3,:), '-', 'Color', [1,0,0], 'LineWidth', 1.5); % Azzurro (z)
hold off
title('Angular Velocity Error','FontSize',20)
set(gca, 'FontSize',12);
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Velocity Error (rad/s)', 'Interpreter', 'latex')
legend('$\dot{e}_{R,roll}$', '$\dot{e}_{R,pitch}$', '$\dot{e}_{R,yaw}$', 'Interpreter', 'latex', 'Location','northeast')
xlim([min(time) max(time)])
grid on;
box on;
exportgraphics(h, 'plot_es_5/angular_velocity_error.pdf');

%% Position Tracking 
l = figure('Renderer','painters','Position',[10 10 900 1000]);

% --- X Position (fucsia)
subplot(3,1,1);
hold on
plot(time, pos(1,:), '-', 'Color', [1, 0, 1], 'LineWidth', 1.5);
plot(time, posdes(1,:), '--', 'Color', [0, 0, 0], 'LineWidth', 1.5);
hold off
ylabel('X (m)', 'Interpreter', 'latex')
legend({'$x$', '$x_{des}$'}, 'Interpreter', 'latex', 'Location', 'northeast')
title('Position Tracking', 'FontSize', 20)
set(gca, 'FontSize', 12);
grid on;
box on;

% --- Y Position (blu)
subplot(3,1,2);
hold on
plot(time, pos(2,:), '-', 'Color', [0.3, 0.75, 0.93], 'LineWidth', 1.5);
plot(time, posdes(2,:), '--', 'Color', [0, 0, 0], 'LineWidth', 1.5);
hold off
ylabel('Y (m)', 'Interpreter', 'latex')
legend({'$y$', '$y_{des}$'}, 'Interpreter', 'latex', 'Location', 'northeast')
set(gca, 'FontSize', 12);
grid on;
box on;

% --- Z Position (rosso)
subplot(3,1,3);
hold on
plot(time, pos(3,:), '-', 'Color', [1, 0, 0], 'LineWidth', 1.5);
plot(time, posdes(3,:), '--', 'Color', [0, 0, 0], 'LineWidth', 1.5);
hold off
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('Z (m)', 'Interpreter', 'latex')
legend({'$z$', '$z_{des}$'}, 'Interpreter', 'latex', 'Location', 'northeast')
set(gca, 'FontSize', 12);
grid on;
box on;

exportgraphics(l, 'plot_es_5/position_tracking.pdf');


%% Orientation Tracking 
z = figure('Renderer','painters','Position',[10 10 900 1000]);

% --- X Position (fucsia)
subplot(3,1,1);
hold on
plot(time, phi, '-', 'Color', [1, 0, 1], 'LineWidth', 1.5);
plot(time, phides, '--', 'Color', [0, 0, 0], 'LineWidth', 1.5);
hold off
ylabel('$\phi$ ', 'Interpreter', 'latex')
legend({'$\phi$ ', '$\phi_{des}$ '}, 'Interpreter', 'latex', 'Location', 'northeast')
title('Orientation Tracking', 'FontSize', 20)
set(gca, 'FontSize', 12);
grid on;
box on;

% --- Y Position (blu)
subplot(3,1,2);
hold on
plot(time, theta, '-', 'Color', [0.3, 0.75, 0.93], 'LineWidth', 1.5);
plot(time, thetades, '--', 'Color', [0, 0, 0], 'LineWidth', 1.5);
hold off
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\theta$ ', 'Interpreter', 'latex')
legend({'$\theta$ ', '$\theta_{des}$ '}, 'Interpreter', 'latex', 'Location', 'northeast')
set(gca, 'FontSize', 12);
grid on;
box on;

% --- Z Position (rosso)
subplot(3,1,3);
hold on
plot(time, csi, '-', 'Color', [1, 0, 0], 'LineWidth', 1.5);
plot(time, csides, '--', 'Color', [0, 0, 0], 'LineWidth', 1.5);
hold off
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\xi$ ', 'Interpreter', 'latex')
legend({'$\xi$ ', '$\xi_{des}$ '}, 'Interpreter', 'latex', 'Location', 'northeast')
set(gca, 'FontSize', 12);
grid on;
box on;

exportgraphics(z, 'plot_es_5/orientation_tracking.pdf');


%% uw and alfa 

m = figure('Renderer','painters','Position',[10 10 900 800]);

% --- uw (in blu)
subplot(2,1,1);
hold on
plot(time, uw(1,:), '-', 'Color', [0, 0.5, 1], 'LineWidth', 1.5);
plot(time, uw(2,:), '-', 'Color', [0, 0, 0], 'LineWidth', 1.5);
plot(time, uw(3,:), '-', 'Color', [0, 0.7, 0.3], 'LineWidth', 1.5);
plot(time, uw(4,:), '-', 'Color', [1, 0.7, 0.3], 'LineWidth', 1.5);
hold off
ylabel('$u_\omega$', 'Interpreter', 'latex')
legend({'$u_{\omega,1}$', '$u_{\omega,2}$', '$u_{\omega,3}$','$u_{\omega,4}$'}, ...
    'Interpreter', 'latex', 'Location', 'northeast')
title('$u_\omega$', 'Interpreter', 'latex', 'FontSize', 20)
set(gca, 'FontSize', 12);
grid on;
box on;

% --- alfa (in rosso)
subplot(2,1,2);
hold on
plot(time, alfa(1,:), '-', 'Color', [1, 0, 0], 'LineWidth', 1.5);
plot(time, alfa(2,:), '-', 'Color', [0.5, 0, 0], 'LineWidth', 1.5);
plot(time, alfa(3,:), '-', 'Color', [0.8, 0.3, 0.3], 'LineWidth', 1.5);
plot(time, alfa(4,:), '-', 'Color', [1, 0.6, 0.3], 'LineWidth', 1.5);
hold off
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\alpha$', 'Interpreter', 'latex')
legend({'$\alpha_1$', '$\alpha_2$', '$\alpha_3$', '$\alpha_4$'}, ...
    'Interpreter', 'latex', 'Location', 'northeast')
title('$\alpha$', 'Interpreter', 'latex', 'FontSize', 20)
set(gca, 'FontSize', 12);
grid on;
box on;

exportgraphics(m, 'plot_es_5/uw_alfa.pdf');
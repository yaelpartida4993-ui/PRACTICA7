clear; clc; close all;

Ra = 2;        
Kt = 0.01;       
b  = 0.0012;     
La = 0.023;     
Ke = 0.01;       
J  = 0.001;      

Va = 12;         

x0 = [0; 0; 0]; 

tspan = [0 2]; 

[t, x] = ode45(@(t,x) motor_dc(t, x, Ra, La, Ke, Kt, b, J, Va), tspan, x0);

theta_m = x(:,1);      
theta_dot_m = x(:,2);  
i_a = x(:,3);          

%% Graficas
figure('Name', 'Respuesta del Motor DC', 'Color', 'w');

% Posición 
subplot(3,1,1);
plot(t, theta_m, 'LineWidth', 1.5, 'Color', 'b');
grid on;
ylabel('\theta_m (rad)');
title('Posición Angular');
xlim([0 2]);

% Velocidad
subplot(3,1,2);
plot(t, theta_dot_m, 'LineWidth', 1.5, 'Color', 'r');
grid on;
ylabel('\omega_m (rad/s)');
title('Velocidad Angular');
xlim([0 2]);

% Corriente
%subplot(3,1,3);
%plot(t, i_a, 'LineWidth', 1.5, 'Color', 'k');
%grid on;
%ylabel('i_a (A)');
%xlabel('Tiempo (s)');
%title('Corriente de Armadura');
%xlim([0 2]);

%% espacio de estados
function dxdt = motor_dc(t, x, Ra, La, Ke, Kt, b, J, Va)

dxdt = zeros(3,1);
dxdt(1) = x(2);
dxdt(2) = (1/J) * (Kt * x(3) - b * x(2));
dxdt(3) = (1/La) * (Va - Ra * x(3) - Ke * x(2));
end
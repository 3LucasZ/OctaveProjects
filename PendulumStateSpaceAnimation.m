% reset environment
clear all; close all; clc

% pendulum equation
f = @(t,theta) [theta(2); -sin(theta(1))];

% plot frame
grid_x = linspace(-2,8,20);
grid_y = linspace(-2,2,20);
[x,y] = meshgrid(grid_x,grid_y);

% create the vector field
t=0; % graph field at t=0
u = zeros(size(x));
v = zeros(size(x));
for i = 1:numel(x)
    theta_prime = f(t,[x(i); y(i)]);
    u(i) = theta_prime(1);
    v(i) = theta_prime(2);
end

% display the vector field
quiver(x,y,u,v,'r'); figure(gcf)
xlabel('angle (theta)')
ylabel('angular velocity (w)')
axis tight equal;

% initial conditions
theta = 1;
w = 0;

% graph the solved equation
tspan = [0,10]
hold on
[ts,ys] = ode45(f,tspan,[theta;w]);
plot(ys(:,1),ys(:,2))
plot(ys(1,1),ys(1,2),'bo') % plot starting point as blue circle
plot(ys(end,1),ys(end,2),'ks') % plot ending point as black square
hold off


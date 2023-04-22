% reset environment
clear all; close all; clc

% pendulum equation
f = @(t,Y) [Y(2); -sin(Y(1))];

% plot frame
grid_x = linspace(-2,8,20);
grid_y = linspace(-2,2,20);
[x,y] = meshgrid(grid_x,grid_y);

disp(horzcat("x sz: ",num2str(size(x))));
disp(horzcat("y sz: ",num2str(size(y))));


% create the vector field
t=0; % graph field at t=0
u = zeros(size(x));
v = zeros(size(x));
for i = 1:numel(x)
    Yprime = f(t,[x(i); y(i)]);
    u(i) = Yprime(1);
    v(i) = Yprime(2);
end

% display the vector field
quiver(x,y,u,v,'r'); figure(gcf)
xlabel('height (h)')
ylabel('velocity (v)')
axis tight equal;
 hds
% initial conditions:
v = 0;
h = 3;
t = 0;

% animation params:
tstep = 0.05;

tspan = linspace(0,1


% graph the solved equation
tspan = [0,3]
hold on
[ts,ys] = ode45(f,tspan,[vi;hi]);
disp(horzcat("ts sz: ",num2str(size(ts))));
disp(horzcat("ys sz: ",num2str(size(ys))));
plot(ys(:,1),ys(:,2))
plot(ys(1,1),ys(1,2),'bo') % plot starting point as blue circle
plot(ys(end,1),ys(end,2),'ks') % plot ending point as black square
pause(step)
hold off


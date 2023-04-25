% reset environment
clear all; close all; clc

% plot frame
grid_x = linspace(-2,8,20);
grid_y = linspace(-2,2,20);
[x,y] = meshgrid(grid_x,grid_y);
xlabel('angle (theta)')
ylabel('angular velocity (w)')

for t=1:1000
  % pendulum equation
  f = @(t,theta) [theta(2); -rand*10*sin(theta(1))];

  % create the shifting vector field
  t=0; % graph field at t=0
  u = zeros(size(x));
  v = zeros(size(x));
  for i = 1:numel(x)
      theta_prime = f(t,[x(i); y(i)]);
      u(i) = theta_prime(1);
      v(i) = theta_prime(2);
  end

  % display the vector field
  graph = quiver(x,y,u,v,'r');

  pause(0.01);

  delete(graph);
endfor

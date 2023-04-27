% reset environment
clear all; close all; clc

% const
G = 6
m = 4.5
r = 0.01905
R = 0.047
Kt = 0.0182
Kv = 56.004

A = (-G*G*Kt)/(R*r*r*m*Kv);
B = (G*Kt)/(R*r*m);

h_min=0;
h_max=1.5;
V = 5;

% state_dot elevator equation
f = @(t,h) [h(2); A*h(2)+B*V];

% plot frame
grid_h = linspace(h_min,h_max,20);
grid_v = linspace(-2,2,20);
[x,y] = meshgrid(grid_h,grid_v);

% create the vector field
t=0; % graph field at t=0
u = zeros(size(x));
v = zeros(size(x));
for i = 1:numel(x)
    state_dot = f(t,[x(i); y(i)]);
    u(i) = state_dot(1);
    v(i) = state_dot(2);
end

% display the vector field
quiver(x,y,u,v,'r'); figure(gcf)
xlabel('(h)eight (m)')
ylabel('(v)elocity (m/s)')
axis tight;

% param
h = 0;
v = 0;
speed = 1;
anim_step=0.01;
state_step=anim_step*speed;
tf = 5;
tspan = 0:state_step:tf;


% animate

for tcur = tspan
  % solve for interval [0->state_step]
  [ts, ys] = ode45(f,[0,state_step],[h;v]);
  % update h, v
  h = ys(end,1)
  h = max(min(h,h_max),h_min);
  v = ys(end,2)
  % plot h, v
  hold on
  point = plot(h,v,'gs','LineWidth',5);
  % plot trace
  hold on
  trace = plot(ys(:,1),ys(:,2),'LineWidth',5,'b');
  hold off
  % pause and reset
  pause(anim_step);
  delete(point);
  hold off
end

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

V = 36

% state_dot elevator equation
f = @(t,h) [h(2); A*h(2)+B*V];

% plot frame
grid_h = linspace(0,6,20);
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
xlabel('height (h)')
ylabel('velocity (v)')
%axis tight equal;

% param
h = 0;
v = 0;
state_step=0.0025;
anim_step=0.05;
tf = 10;
tspan = 0:state_step:tf;


% animate
hold on
[ts,ys] = ode45(f,tspan,[h;v]);
plot(ys(:,1),ys(:,2))
plot(ys(1,1),ys(1,2),'bo') % plot starting point as blue circle
plot(ys(end,1),ys(end,2),'ks') % plot ending point as black square

for tcur = tspan
  point = plot(h,v,'bo');

  pause(anim_step);
  [ts, ys] = ode45(f,[0,state_step],[h;v]);
  h = ys(end,1)
  v = ys(end,2)

  delete(point);
end
hold off



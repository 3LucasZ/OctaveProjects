% reset environment
clear all; close all; clc

% const var
G = 6 % gear ratio output to input
m = 4.5 % mass kg
r = 0.01905 % pulley radius m
R = 0.047 % resistance on motor ohm
Kt = 0.0182 % motor constant
Kv = 56.004 % motor constant

A = (-G*G*Kt)/(R*r*r*m*Kv);
B = (G*Kt)/(R*r*m);

h_min=0;
h_max=1.5;

speed = 1;
state_step=0.01; % time per vector field
anim_step=0.01; % time per frame

% dyna var
global V = 0;
h = 0;
v = 0;

% verbose
disp("A:");
disp(A);
disp("B");
disp(B);

% plot frame
grid_h = linspace(h_min,h_max,20);
grid_v = linspace(-2,2,20);
[x, y] = meshgrid(grid_h,grid_v);
xlabel('(h)eight (m)');
ylabel('(v)elocity (m/s)');
axis tight;

% slider trigger
function update (src, event)
  global V;
  V = get (src, "value");
  disp(V);
end

% slider
slider = uicontrol (
         'style', 'slider',
         'units', 'normalized',
         'position', [0.1, 0.1, 0.8, 0.1],
         'min', -12,
         'max', 12,
         'value', 0,
         'callback', {@update}
       );

% run animation
for t=1:1000000
  % update state_dot elevator equation
  f = @(t,h_) [h_(2); A*h_(2)+B*V];

  % update vector field (at t = 0)
  field_u = zeros(size(x));
  field_v = zeros(size(x));
  for i = 1:numel(x)
      state_dot = f(0,[x(i); y(i)]);
      field_u(i) = state_dot(1);
      field_v(i) = state_dot(2);
  end

  % update solution
  [ts,ys] = ode45(f,[0,state_step],[h;v]);

  % update h,v
  h = ys(end,1);
  h = max(min(h,h_max),h_min);
  v = ys(end,2);

  % draw vector field
  hold on;
  field = quiver(x,y,field_u,field_v,'r');
  hold off;

  % draw point
  hold on;
  point = plot(h,v,'gs','LineWidth',5);
  hold off;

  % draw history
  hold on
  trace = plot(ys(:,1),ys(:,2),'b','LineWidth',2);
  hold off

  % pause, reset
  pause(anim_step);
  delete(field);
  delete(point);
end

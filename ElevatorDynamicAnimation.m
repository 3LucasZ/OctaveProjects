% reset environment
clear all; close all; clc

% const var
G = 6
m = 4.5
r = 0.01905
R = 0.047
Kt = 0.0182
Kv = 56.004

A = (-G*G*Kt)/(R*r*r*m*Kv);
B = (G*Kt)/(R*r*m);

state_step=0.01; % time per vector field
anim_step=0.01; % time per frame
vision=1; % seconds into the future you can see

max_h = 6;
min_h = 0;

% dyna var
global V = 0;
h = max_h/2;
v = 0;

% plot frame

grid_h = linspace(min_h,max_h,20);
grid_v = linspace(-2,2,20);
[x, y] = meshgrid(grid_h,grid_v);
xlabel('height (h)')
ylabel('velocity (v)')

% slider trigger
function update (src, event)
  global V;
  V = get (src, "value");
  disp(V);
end

% slider to control voltage
slider = uicontrol (                    ...
         'style', 'slider',                ...
         'Units', 'normalized',            ...
         'position', [0.1, 0.1, 0.8, 0.1], ...
         'min', -12,                         ...
         'max', 12,                        ...
         'value', 0,                      ...
         'callback', {@update}          ...
       );

% run animation
for t=1:1000000
  % state_dot elevator equation
  f = @(t,h_) [h_(2); A*h_(2)+B*V];

  % vector field (at t = 0)
  field_u = zeros(size(x));
  field_v = zeros(size(x));
  for i = 1:numel(x)
      state_dot = f(0,[x(i); y(i)]);
      field_u(i) = state_dot(1);
      field_v(i) = state_dot(2);
  end

  % draw vector field
  field = quiver(x,y,field_u,field_v,'r');
  axis tight equal;

  % draw future
  [ts,ys] = ode45(f,[0,vision],[h;v]);
  hold on;
  future = plot(ys(:,1),ys(:,2));
  hold off;
  hold on;
  fin = plot(ys(end,1),ys(end,2),'ks');
  hold off;

  % update and draw point
  [ts,ys] = ode45(f,[0,state_step],[h;v]);
  h = ys(end,1);
  h = min(h,max_h);
  h = max(h,min_h);
  v = ys(end,2);
  hold on;
  point = plot(h,v,'bo');
  hold off;

  pause(anim_step);

  % clear
  delete(field);
  delete (future);
  delete(fin);
  delete(point);
end

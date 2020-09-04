% 3.2 Mini exercise: Spirals and other flow patterns
% Two-variable linear systems of ODEs can exhibit only a few patterns of behavior. 
% An attractive steady state where solutions spiral inwards
% An attractive steady state where solutions do not spiral in
% A repulsive steady state where solutions spiral outwards - a=1, b=2, c=-1, d=2
% A repulsive steady state where solutions do not spiral out - a=1, b=2, c=1, d=2
% A pure oscillation - a=-1, b=-2, c=2, d=1
% One more category not contained in the list - saddle point? a = -2, b = 0, c = 0, d= 2
% Find parameters that give one of each.
% You should be able to achieve these by only varying a,b,c and d below, exploring negative numbers too.

% parameters
a = -2;
b = 0;
c = 0;
d = 2;

% model equations
f =@(x,y) a*x + b*y; 
g =@(x,y) c*x + d*y;

[T, X] = ode45(@(t,x)[f(x(1),x(2));g(x(1),x(2))], [0,1000], [.1,.1] );

figure; hold on;
set(gca, 'xlim', [-1, 1], 'ylim', [-1, 1])
ylabel('x');
xlabel('y')

xArray = linspace(-1,1,16);
yArray = linspace(-1,1,16);

[xMesh,yMesh] = meshgrid(xArray, yArray);

% the Matlab plot command for a field of arrows is:
quiver(xMesh, yMesh, f(xMesh, yMesh), g(xMesh,yMesh))

plot(X(:,1),X(:,2),'-r')
plot(X(end,1),X(end,2), 'or')
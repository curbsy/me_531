% Makenzie Brian
% October 2018
% ME 531
% Homework 2

% Problem 2
% Part a
% make grid of points
[x, y] = meshgrid(-.5:.1:1.5,-.5:.1:1.5);

% system of equations
dx = 2.*x -2.*x.*x -x.*y
dy = 2.*y -x.*y -2.*y.*y

L = sqrt(dx.^2+dy.^2); 

% grid of arrows to show system
quiver(x, y, dx./L, dy./L, 0.5)


f = @(t,q) [2*q(1)-2*q(1)*q(1)-q(1)*q(2); 2*q(2)-q(1)*q(2)-2*q(2)*q(2)];

% for ode45
span = [0,5];

hold on

% Plot 5 trajectories based on different initial conditions
% IC: 1.5, 1.5
[T,Y] = ode45(f,span,[1.5,1.5]);
plot(Y(:,1),Y(:,2))
% IC: 1.5, 0.5
[T,Y] = ode45(f,span,[1.5,0.5]);
plot(Y(:,1),Y(:,2))
% IC: 0.5, 1.5
[T,Y] = ode45(f,span,[0.5,1.5]);
plot(Y(:,1),Y(:,2))
% IC: 0.1, 0.15
[T,Y] = ode45(f,span,[0.1,0.15]);
plot(Y(:,1),Y(:,2))
% IC: 0.1, 0.01
[T,Y] = ode45(f,span,[0.1,0.01]);
plot(Y(:,1),Y(:,2))

title('Plot 1: Nonlinear');
legend('Grid', 'Trajectory 1', 'Trajectory 2', 'Trajectory 3', 'Trajectory 4', 'Trajectory 5');
xlabel('x'), ylabel('y');

figure

% Part b
% system of equations of Jacobian Linearization
dx = -4/3 .*x - 2/3 .*y;
dy = -2/3 .*x - 4/3 .*y;

L = sqrt(dx.^2+dy.^2); 

% grid of arrows to show system
quiver(x, y, dx./L, dy./L, 0.5)

f = @(t,q) [(-4/3)*q(1)-(2/3)*q(2); (-2/3)*q(1)-(4/3)*q(2)];

% for ode45
span = [0,5];

hold on

% Plot 5 trajectories based on different initial conditions
% IC: 1.5, 1.5
[T,Y] = ode45(f,span,[1.5,1.5]);
plot(Y(:,1),Y(:,2))
% IC: 1.5, 0.5
[T,Y] = ode45(f,span,[1.5,0.5]);
plot(Y(:,1),Y(:,2))
% IC: 0.5, 1.5
[T,Y] = ode45(f,span,[0.5,1.5]);
plot(Y(:,1),Y(:,2))
% IC: 0.1, 0.15
[T,Y] = ode45(f,span,[0.1,0.15]);
plot(Y(:,1),Y(:,2))
% IC: 0.1, 0.01
[T,Y] = ode45(f,span,[0.1,0.01]);
plot(Y(:,1),Y(:,2))

title('Plot 2: Linearized');
legend('Grid', 'Trajectory 1', 'Trajectory 2', 'Trajectory 3', 'Trajectory 4', 'Trajectory 5');
xlabel('x'), ylabel('y')

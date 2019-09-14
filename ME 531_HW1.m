% make variable t
t = sym ('t')
% system state matrix
A = [(2*exp(-t))-(exp(-2*t)) (exp(-t))-(exp(-2*t));2*(exp(-2*t))-2*(exp(-t)) 2*(exp(-2*t))-(exp(-t))]
% initial conditions
x0 = [1; -1];
% time vector for plotting
T = 0:.01:10;
% multiple state matrix by initial conditions
sol = A*x0
% apply over time
output = subs(sol, t, 0:.01:10)

% plot solutions
subplot(121), plot(T, output(1,:))
xlabel('Time (sec)'), ylabel('x_1')
legend('IC 1')
grid on
subplot(122), plot(T, output(2,:))
xlabel('Time (sec)'), ylabel('x_2')
legend('IC -1')
grid on


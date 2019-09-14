% Makenzie Brian
% ME 531
% Homework 4

% Problem 1

clear all

% Matricies and values
A = [0, 1; -2/5, -2/5];
B = [0; 1/5];
C = [1 0];
ref = 0.25;

% For a settling time of approximately 2 sec
zeta = 1/sqrt(2); % damping ratio
omega = 2.8; % natural frequency

% Desired poles
op1 = -zeta*omega+(omega*(1-zeta^2)^0.5)*1i;
op2 = -zeta*omega-(omega*(1-zeta^2)^0.5)*1i;

% Find the feedback gains
K = place(A, B, [op1, op2]);

% The feedforward reference gain is 
k_r = -1/(C*inv(A-B*K)*B);

% Find the observer gain with Ackerman's formula. Note, we must use the 
% transpose of A and C.
L = place(A', C', 2*[op1 op2]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setting up augmented system for output feedback
new_A = [(A-B*K) (B*K); zeros(2, 2) (A-L'*C)];
new_B = [B*k_r ; [0; 0]];

new_f = @(t, x) [new_A*x + new_B*ref];
[t_of,x_of] = ode45(new_f, [0, 4], [0, 0, 0.5, -0.5]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% State-feedback version, based on HW3
% Create global variables to track the control input with the function call
global u_Global i_Global;
u_Global = [];
i_Global = 1;

[t_sf, x_sf] = ode45(@(t, x) stateF(t, x, A, B, K, k_r, ref), [0 4], [0, 0]);

% First graph - Output (displacement) comparison between
% state and output feedback methods
figure;
plot(t_sf, x_sf(:, 1))
hold on
plot(t_of, x_of(:, 1))
hold off
xlabel('Time (sec)')
ylabel('x (m)')
legend('State Feedback', 'Output Feedback')
title('Comparison of State-Feedback and Output-Feedback Controllers')

% Second Graph - Error convergence to 0
figure;
plot(t_of, x_of(:, 3), t_of, x_of(:, 4))
xlabel('Time (sec)')
ylabel('Estimation Error')
legend('e1', 'e2')
title('Estimation Error Over Time')

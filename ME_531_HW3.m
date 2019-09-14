% Makenzie Brian
% ME 531
% Homework 3

% Problem 1 Part b

clear all

% variables
g = 9.8; % m/sec^2
sigma1 = 0.415;
sigma2 = 0.0198;
alpha1 = 0.0111;
alpha2 = 1.43;
n = 6.27;

% Example system
A = [0, 1, 0; 0, -sigma1, -alpha1; -g, -alpha2, -sigma2];
B = [0; n; g];
C = [1 0 0];
D = 0;

% Initial conditions
x0 = [0; 0; 0]; 

% Check stability of the open loop system
eig(A)

% Create a state space model
sys = ss(A, B, C, D);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Desired closed loop eigenvalues
p = [-2.667 + 4.619i, -2.667 - 4.619i, -200];
% Command signal/reference input
ref = 1;
% Find the feedback gains
K = place(A, B, p);

% The feedforward reference gain is 
k_r = -1/(C*inv(A-B*K)*B);

% Create global variables to track the control input with the function call
global u_Global i_Global;
u_Global = [];
i_Global = 1;

% Simulate the closed loop response
[t,x] = ode45(@(t,x) stateF(t,x,A,B,K,k_r,ref),[0 5],x0);

figure

% states
subplot(3,1,1)
plot(t,x(:,1))
hold on
plot(t,x(:,2))
plot(t,x(:,3),'g')
hold off
xlabel('Time (sec)')
ylabel('States')
legend('x_1','x_2','x_3')

% outputs
subplot(3,1,2)
plot(t,x(:,1))
xlabel('Time (sec)')
ylabel('Output')

% control inputs
subplot(3,1,3)
plot(t,u_Global(1:length(t)))
xlabel('Time (sec)')
ylabel('Control input')

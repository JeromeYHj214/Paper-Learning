%-----------------------
%生成带结构的点模式
%-----------------------
clc;
clear;
close;
dimension = 2;
num_observation = 100;
num_test = 20;
N = num_observation + num_test;

%% 第六类点模式
num_X6 = 4;

m_X6_x1 = [1; 1];
S_X6_x1 = [2 0; 0 2];
X6_x1 = mvnrnd(m_X6_x1, S_X6_x1, N)';

m_X6_e1 = [0; 0];
S_X6_e1 = 3*[1 0; 0 1];
X6_e1 = mvnrnd(m_X6_e1, S_X6_e1,N)';
X6_x2 = X6_x1 + X6_e1;

m_X6_e2 = [0; 0];
S_X6_e2 = 4*[1 0; 0 1];
X6_e2 = mvnrnd(m_X6_e2, S_X6_e2,N)';
X6_x3 = X6_x2 + X6_e2;

m_X6_e3 = [0; 0];
S_X6_e3 = 5*[1 0; 0 1];
X6_e3 = mvnrnd(m_X6_e3, S_X6_e3,N)';
X6_x4 = X6_x3 + X6_e3;

X6 = zeros(dimension, num_X6, N);
for i = 1:N
    X6(:, 1, i)  = X6_x1(:,i);
    X6(:, 2, i)  = X6_x2(:,i);
    X6(:, 3, i)  = X6_x3(:,i);
    X6(:, 4, i)  = X6_x4(:,i);
end

figure(6);

for i = 1:N
    plot(X6(1,:,i), X6(2,:,i),'.');
    hold on;
end

%% 第七类点模式
num_X7 = 4;

m_X7_x1 = [1; 1];
S_X7_x1 = [2 0; 0 2];
X7_x1 = mvnrnd(m_X7_x1, S_X7_x1, N)';

m_X7_e1 = [0; 0];
S_X7_e1 = 3*[1 0; 0 1];
X7_e1 = mvnrnd(m_X7_e1, S_X7_e1,N)';
X7_x2 = X7_x1 + X7_e1;

m_X7_e2 = [0; 0];
S_X7_e2 = 4*[1 0; 0 1];
X7_e2 = mvnrnd(m_X7_e2, S_X7_e2,N)';
X7_x3 = X7_x2 + X7_e2;

m_X7_e3 = [0; 0];
S_X7_e3 = 4*[1 0; 0 1];
X7_e3 = mvnrnd(m_X7_e3, S_X7_e3,N)';
X7_x4 = X7_x2 + X7_e3;

X7 = zeros(dimension, num_X7, N);
for i = 1:N
    X7(:, 1, i)  = X7_x1(:,i);
    X7(:, 2, i)  = X7_x2(:,i);
    X7(:, 3, i)  = X7_x3(:,i);
    X7(:, 4, i)  = X7_x4(:,i);
end

figure(7);

for i = 1:N
    plot(X7(1,:,i), X7(2,:,i),'.');
    hold on;
end

%% 第八类点模式
num_X8 = 4;

m_X8_x1 = [1; 1];
S_X8_x1 = [2 0; 0 2];
X8_x1 = mvnrnd(m_X8_x1, S_X8_x1, N)';

m_X8_e1 = [0; 0];
S_X8_e1 = 3*[1 0; 0 1];
X8_e1 = mvnrnd(m_X8_e1, S_X8_e1,N)';
X8_x2 = X8_x1 + X8_e1;

m_X8_e2 = [0; 0];
S_X8_e2 = 3*[1 0; 0 1];
X8_e2 = mvnrnd(m_X8_e2, S_X8_e2,N)';
X8_x3 = X8_x1 + X8_e2;

m_X8_e3 = [0; 0];
S_X8_e3 = 4*[1 0; 0 1];
X8_e3 = mvnrnd(m_X8_e3, S_X8_e3,N)';
X8_x4 = X8_x1 + X8_e3;

X8 = zeros(dimension, num_X8, N);
for i = 1:N
    X8(:, 1, i)  = X8_x1(:,i);
    X8(:, 2, i)  = X8_x2(:,i);
    X8(:, 3, i)  = X8_x3(:,i);
    X8(:, 4, i)  = X8_x4(:,i);
end

figure(8);

for i = 1:N
    plot(X8(1,:,i), X8(2,:,i),'.');
    hold on;
end
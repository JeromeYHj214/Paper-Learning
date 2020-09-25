clc; clear; close;
dimension = 2;
N = 100;
%% 第一类点模式
num_X1 = 4;

m_X1_x1 = [1; 1];
S_X1_x1 = [2 0; 0 2];
X1_x1 = mvnrnd(m_X1_x1, S_X1_x1, N)';

m_X1_e1 = [0; 0];
S_X1_e1 = 3*[1 0; 0 1];
X1_e1 = mvnrnd(m_X1_e1, S_X1_e1,N)';
X1_x2 = X1_x1 + X1_e1;

m_X1_e2 = [0; 0];
S_X1_e2 = 4*[1 0; 0 1];
X1_e2 = mvnrnd(m_X1_e2, S_X1_e2,N)';
X1_x3 = X1_x2 + X1_e2;

m_X1_e3 = [0; 0];
S_X1_e3 = 5*[1 0; 0 1];
X1_e3 = mvnrnd(m_X1_e3, S_X1_e3,N)';
X1_x4 = X1_x3 + X1_e3;

X1 = cell(2,N);
for i = 1:N
    X1{1,i}(:,1) = X1_x1(:,i);
    X1{1,i}(:,2) = X1_x2(:,i);
    X1{1,i}(:,3) = X1_x3(:,i);
    X1{1,i}(:,4) = X1_x4(:,i);
    X1{2,i} = 1;
end

subplot(2,2,1);

for i = 1:N
    plot(X1{1,i}(1,:), X1{1,i}(2,:),'.');
    hold on;
end

%% 第二类点模式
num_X2 = 4;

m_X2_x1 = [1; 1];
S_X2_x1 = [2 0; 0 2];
X2_x1 = mvnrnd(m_X2_x1, S_X2_x1, N)';

m_X2_e1 = [0; 0];
S_X2_e1 = 3*[1 0; 0 1];
X2_e1 = mvnrnd(m_X2_e1, S_X2_e1,N)';
X2_x2 = X2_x1 + X2_e1;

m_X2_e2 = [0; 0];
S_X2_e2 = 4*[1 0; 0 1];
X2_e2 = mvnrnd(m_X2_e2, S_X2_e2,N)';
X2_x3 = X2_x2 + X2_e2;

m_X2_e3 = [0; 0];
S_X2_e3 = 4*[1 0; 0 1];
X2_e3 = mvnrnd(m_X2_e3, S_X2_e3,N)';
X2_x4 = X2_x2 + X2_e3;

X2 = cell(2,N);
for i = 1:N
    X2{1,i}(:,1) = X2_x1(:,i);
    X2{1,i}(:,2) = X2_x2(:,i);
    X2{1,i}(:,3) = X2_x3(:,i);
    X2{1,i}(:,4) = X2_x4(:,i);
    X2{2,i} = 2;
end

subplot(2,2,2);

for i = 1:N
    plot(X2{1,i}(1,:), X2{1,i}(2,:),'.');
    hold on;
end

%% 第三类点模式
num_X3 = 4;

m_X3_x1 = [1; 1];
S_X3_x1 = [2 0; 0 2];
X3_x1 = mvnrnd(m_X3_x1, S_X3_x1, N)';

m_X3_e1 = [0; 0];
S_X3_e1 = 3*[1 0; 0 1];
X3_e1 = mvnrnd(m_X3_e1, S_X3_e1,N)';
X3_x2 = X3_x1 + X3_e1;

m_X3_e2 = [0; 0];
S_X3_e2 = 3*[1 0; 0 1];
X3_e2 = mvnrnd(m_X3_e2, S_X3_e2,N)';
X3_x3 = X3_x1 + X3_e2;

m_X3_e3 = [0; 0];
S_X3_e3 = 4*[1 0; 0 1];
X3_e3 = mvnrnd(m_X3_e3, S_X3_e3,N)';
X3_x4 = X3_x2 + X3_e3;

X3 = cell(2,N);
for i = 1:N
    X3{1,i}(:,1) = X3_x1(:,i);
    X3{1,i}(:,2) = X3_x2(:,i);
    X3{1,i}(:,3) = X3_x3(:,i);
    X3{1,i}(:,4) = X3_x4(:,i);
    X3{2,i} = 3;
end

subplot(2,2,3);

for i = 1:N
    plot(X3{1,i}(1,:), X3{1,i}(2,:),'.');
    hold on;
end

%% 第四类点模式
num_X4 = 4;

m_X4_x1 = [1; 1];
S_X4_x1 = [2 0; 0 2];
X4_x1 = mvnrnd(m_X4_x1, S_X4_x1, N)';

m_X4_e1 = [0; 0];
S_X4_e1 = 3*[1 0; 0 1];
X4_e1 = mvnrnd(m_X4_e1, S_X4_e1,N)';
X4_x2 = X4_x1 + X4_e1;

m_X4_e2 = [0; 0];
S_X4_e2 = 3*[1 0; 0 1];
X4_e2 = mvnrnd(m_X4_e2, S_X4_e2,N)';
X4_x3 = X4_x1 + X4_e2;

m_X4_e3 = [0; 0];
S_X4_e3 = 3*[1 0; 0 1];
X4_e3 = mvnrnd(m_X4_e3, S_X4_e3,N)';
X4_x4 = X4_x1 + X4_e3;

X4 = cell(2,N);
for i = 1:N
    X4{1,i}(:,1) = X4_x1(:,i);
    X4{1,i}(:,2) = X4_x2(:,i);
    X4{1,i}(:,3) = X4_x3(:,i);
    X4{1,i}(:,4) = X4_x4(:,i);
    X4{2,i} = 4;
end

subplot(2,2,4);

for i = 1:N
    plot(X4{1,i}(1,:), X4{1,i}(2,:),'.');
    hold on;
end

save('Sim_data','X1','X2','X3','X4');
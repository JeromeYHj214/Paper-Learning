%% 第八类点模式
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

X4 = zeros(dimension, num_X4, N);
for i = 1:N
    X4(:, 1, i)  = X4_x1(:,i);
    X4(:, 2, i)  = X4_x2(:,i);
    X4(:, 3, i)  = X4_x3(:,i);
    X4(:, 4, i)  = X4_x4(:,i);
end

figure(4);

for i = 1:N
    plot(X4(1,:,i), X4(2,:,i),'.');
    hold on;
end
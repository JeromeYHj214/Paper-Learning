%----------------------------------------------------
% 由位置X1；偏差向量e2、e3、e4；观测噪声d1、d2、d3、d3.
%----------------------------------------------------
clc;clear;close;
feature_dimension = 2;
N = 100;
%% 四点链式结构
m_x1 = [4 16];  S_x1 = 0.1 * eye(2);
m_e2 = [4 -4];  S_e2 = 0.1 * eye(2);
m_e3 = [4 -4];  S_e3 = 0.1 * eye(2);
m_e4 = [4 -4];  S_e4 = 0.1 * eye(2);
m_d1 = [0 0];   S_d1 = 0.1 * eye(2);
m_d2 = [0 0];   S_d2 = 0.1 * eye(2);
m_d3 = [0 0];   S_d3 = 0.1 * eye(2);
m_d4 = [0 0];   S_d4 = 0.1 * eye(2);
X1 = cell(1,N);
X1_ori = cell(1,N);
x1 = mvnrnd(m_x1, S_x1, N);
e2 = mvnrnd(m_e2, S_e2, N);
e3 = mvnrnd(m_e3, S_e3, N);
e4 = mvnrnd(m_e4, S_e4, N);
d1 = mvnrnd(m_d1, S_d1, N);
d2 = mvnrnd(m_d2, S_d2, N);
d3 = mvnrnd(m_d3, S_d3, N);
d4 = mvnrnd(m_d4, S_d4, N);
x2 = x1 + e2;
x3 = x2 + e3;
x4 = x3 + e4;
x1_n = x1 + d1;
x2_n = x2 + d2;
x3_n = x3 + d3;
x4_n = x4 + d4;
for i = 1:N
    X1{i} = x1_n(i,:);
    X1{i} = [X1{i};x2_n(i,:)];
    X1{i} = [X1{i};x3_n(i,:)];
    X1{i} = [X1{i};x4_n(i,:)];
    X1{i}(1,3) = 1;
    X1{i}(2,3) = 2;
    X1{i}(3,3) = 3;
    X1{i}(4,3) = 4;
    X1_ori{i} = X1{i};
    %% 随机删除点
    a = rand();
    b = randperm(4);
    if a <= 0.15
        del = b(1:3);
    elseif a > 0.15 && a <= 0.25
        del =  b(1:2);
    elseif a > 0.25 && a <= 0.3
        del = b(1);
    else
        del = [];
    end
    
    len = length(del);
    if len
        for j = 1:len
            n = length(X1{i}(:,3));
            for k = 1:n
                if del(j) == X1{i}(k,3)
                    X1{i}(k,:) = [];
                    break
                end
            end
        end
    end
    % 随机删除特征点程序尾
end
figure(1);
for i = 1:100
    subplot(10,10,i)
    plot(X1{i}(:,1),X1{i}(:,2),'+','color','b')
    hold on;
end
figure(2);
for i = 1:100
    plot(X1{i}(:,1),X1{i}(:,2),'+','color','b')
    hold on;
end

count = 0;
for i = 1:100
    dis = (X1_ori{i}(4,1) - 16)^2 + (X1_ori{i}(4,2) - 4)^2;
    if dis < 0.898
        count = count + 1;
    end
end
count
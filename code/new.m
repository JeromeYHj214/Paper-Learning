%----------------------------------------------------
% 由位置X1；偏差向量e2、e3、e4；观测噪声d1,d2,d3.
%----------------------------------------------------
clc;clear;close;
feature_dimension = 2;
N = 100;
%% 三点链式结构
m_x1 = [4 16];  S_x1 = 0.01 * eye(2);
m_e2 = [4 -4];  S_e2 = 0.01 * eye(2);
m_e3 = [4 -4];  S_e3 = 0.01 * eye(2);
m_n1 = [0 0];   S_n1 = 0.01 * eye(2);
m_n2 = [0 0];   S_n2 = 0.01 * eye(2);
m_n3 = [0 0];   S_n3 = 0.01 * eye(2);

X1 = cell(1,N);
X1_ori = cell(1,N);
X2 = cell(1,N);
X2_ori = cell(1,N);

x1 = mvnrnd(m_x1, S_x1, N);
e2 = mvnrnd(m_e2, S_e2, N);
e3 = mvnrnd(m_e3, S_e3, N);

n1 = mvnrnd(m_n1, S_n1, N);
n2 = mvnrnd(m_n2, S_n2, N);
n3 = mvnrnd(m_n3, S_n3, N);

x2 = x1 + e2;
x3 = x2 + e3;

x1_n = x1 + n1;
x2_n = x2 + n2;
x3_n = x3 + n3;

for i = 1:N
    X1{i} = x1_n(i,:);
    X1{i} = [X1{i};x2_n(i,:)];
    X1{i} = [X1{i};x3_n(i,:)];
    X2{i} = x1(i,:);
    X2{i} = [X2{i};x2(i,:)];
    X2{i} = [X2{i};x3(i,:)];
   
    X1{i}(1,3) = 1;
    X1{i}(2,3) = 2;
    X1{i}(3,3) = 3;
    X2{i}(1,3) = 1;
    X2{i}(2,3) = 2;
    X2{i}(3,3) = 3;
   
    X1_ori{i} = X1{i};
    X2_ori{i} = X2{i};
    %% 随机删除点
    a = rand();
    b = randperm(3);
    if a <= 0.05
        del = b(1:2);
    elseif a > 0.05 && a <= 0.15
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
                    X2{i}(k,:) = [];
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
    plot(X1{i}(:,1),X1{i}(:,2),'+','color','b');
    hold on;
    plot(X2{i}(:,1),X2{i}(:,2),'x','color','r');
    hold on;
end
figure(2);
for i = 1:100
    plot(X1{i}(:,1),X1{i}(:,2),'+','color','b');
    plot(X2{i}(:,1),X2{i}(:,2),'x','color','r');
    hold on;
end
save('data_of_3.mat','X1','X1_ori','X2','X2_ori');
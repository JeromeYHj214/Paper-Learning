clc; clear; close;

feature_dimension = 2;
num_pattern = 4;
N = 100;

%% 第一类点模式
%位置编码顺序（第三列为位置编码） 1连2,2连3,3连4
% real_X1 = [1, 1, 1;1, 10, 2;10, 10, 3;10, 1,4];
real_X1 = [4, 16, 1;8, 12, 2;12, 8, 3;16, 4 ,4];

m_X1_e1 = [0; 0];
S_X1_e1 = 0.1*[1 0; 0 1];
X1_e1 = mvnrnd(m_X1_e1, S_X1_e1,N);

m_X1_e2 = [0; 0];
S_X1_e2 = 0.1*[1 0; 0 1];
X1_e2 = mvnrnd(m_X1_e2, S_X1_e2,N);

m_X1_e3 = [0; 0];
S_X1_e3 = 0.1*[1 0; 0 1];
X1_e3 = mvnrnd(m_X1_e3, S_X1_e3,N);

m_X1_e4 = [0; 0];
S_X1_e4 = 0.1*[1 0; 0 1];
X1_e4 = mvnrnd(m_X1_e4, S_X1_e4,N);

X1 = cell(1,N);
for i = 1:N
    i;
    tmp_X1 = real_X1;
    tmp_X1(1,1:2) = tmp_X1(1,1:2) + X1_e1(i,:);
    tmp_X1(2,1:2) = tmp_X1(2,1:2) + X1_e2(i,:);
    tmp_X1(3,1:2) = tmp_X1(3,1:2) + X1_e3(i,:);
    tmp_X1(4,1:2) = tmp_X1(4,1:2) + X1_e4(i,:);
    X1{i} = tmp_X1;
    %  随机删除特征点程序首
    a = rand(1);
    b = randperm(4);
    if a <= 0.05
        del = b(1:3);
    elseif a > 0.05 && a <= 0.15
        del =  b(1:2);
    elseif a > 0.15 && a <= 0.3
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

%% 第二类点模式
%位置编码顺序（第三列为位置编码） 1连2,1连3,3连4
% real_X2 = [1, 1, 1;1, 10, 2;10, 10, 4;10, 1, 3];
real_X2 = [10, 20, 1;5, 15, 2;5, 10, 3;10, 15, 4];

m_X2_e1 = [0; 0];
S_X2_e1 = 0.1*[1 0; 0 1];
X2_e1 = mvnrnd(m_X2_e1, S_X2_e1,N);

m_X2_e2 = [0; 0];
S_X2_e2 = 0.1*[1 0; 0 1];
X2_e2 = mvnrnd(m_X2_e2, S_X2_e2,N);

m_X2_e3 = [0; 0];
S_X2_e3 = 0.1*[1 0; 0 1];
X2_e3 = mvnrnd(m_X2_e3, S_X2_e3,N);

m_X2_e4 = [0; 0];
S_X2_e4 = 0.1*[1 0; 0 1];
X2_e4 = mvnrnd(m_X2_e4, S_X2_e4,N);

X2 = cell(1,N);
for i = 1:N
    i;
    tmp_X2 = real_X2;
    tmp_X2(1,1:2) = tmp_X2(1,1:2) + X2_e1(i,:);
    tmp_X2(2,1:2) = tmp_X2(2,1:2) + X2_e2(i,:);
    tmp_X2(3,1:2) = tmp_X2(3,1:2) + X2_e3(i,:);
    tmp_X2(4,1:2) = tmp_X2(4,1:2) + X2_e4(i,:);
    X2{i} = tmp_X2;
    %  随机删除特征点程序首
    a = rand(1);
    b = randperm(4);
    if a <= 0.05
        del = b(1:3);
    elseif a > 0.05 && a <= 0.15
        del =  b(1:2);
    elseif a > 0.15 && a <= 0.3
        del = b(1);
    else
        del = [];
    end
    len = length(del);
    if len
        for j = 1:len
            n = length(X2{i}(:,3));
            for k = 1:n
                if del(j) == X2{i}(k,3)
                    X2{i}(k,:) = [];
                    break
                end
            end
        end
    end
    % 随机删除特征点程序尾
end
figure(2);
for i = 1:100
    subplot(10,10,i)
    plot(X2{i}(:,1),X2{i}(:,2),'*','color','r')
    hold on;
end

%% 第三类点模式
%位置编码顺序(第三列为位置编码） 1连2,1连3,1连4
% real_X3 = [1, 1, 1;1, 10, 2;10, 10, 3;10, 1,4];
real_X3 = [10, 20, 1;10, 15, 2;5, 10, 3;15, 10,4];

m_X3_e1 = [0; 0];
S_X3_e1 = 0.1*[1 0; 0 1];
X3_e1 = mvnrnd(m_X3_e1, S_X3_e1,N);

m_X3_e2 = [0; 0];
S_X3_e2 = 0.1*[1 0; 0 1];
X3_e2 = mvnrnd(m_X3_e2, S_X3_e2,N);

m_X3_e3 = [0; 0];
S_X3_e3 = 0.1*[1 0; 0 1];
X3_e3 = mvnrnd(m_X3_e3, S_X3_e3,N);

m_X3_e4 = [0; 0];
S_X3_e4 = 0.1*[1 0; 0 1];
X3_e4 = mvnrnd(m_X3_e4, S_X3_e4,N);

X3 = cell(1,N);
for i = 1:N
    i;
    tmp_X3 = real_X3;
    tmp_X3(1,1:2) = tmp_X3(1,1:2) + X3_e1(i,:);
    tmp_X3(2,1:2) = tmp_X3(2,1:2) + X3_e2(i,:);
    tmp_X3(3,1:2) = tmp_X3(3,1:2) + X3_e3(i,:);
    tmp_X3(4,1:2) = tmp_X3(4,1:2) + X3_e4(i,:);
    X3{i} = tmp_X3;
    %  随机删除特征点程序首
    a = rand(1);
    b = randperm(4);
    if a <= 0.05
        del = b(1:3);
    elseif a > 0.05 && a <= 0.15
        del =  b(1:2);
    elseif a > 0.15 && a <= 0.3
        del = b(1);
    else
        del = [];
    end
    len = length(del);
    if len
        for j = 1:len
            n = length(X3{i}(:,3));
            for k = 1:n
                if del(j) == X3{i}(k,3)
                    X3{i}(k,:) = [];
                    break
                end
            end
        end
    end
    % 随机删除特征点程序尾
end
figure(3);
for i = 1:100
    subplot(10,10,i)
    plot(X3{i}(:,1),X3{i}(:,2),'o','color','g')
    hold on;
end
clc; clear; close;

feature_dimension = 2;
num_pattern = 4;
N = 100;
%% 第一类点模式

real_X1 = [1, 1, 1;1, 10, 2;10, 10, 3;10, 1,4];

m_X1_e1 = [0; 0];
S_X1_e1 = 2*[1 0; 0 1];
X1_e1 = mvnrnd(m_X1_e1, S_X1_e1,N);

m_X1_e2 = [0; 0];
S_X1_e2 = 2*[1 0; 0 1];
X1_e2 = mvnrnd(m_X1_e2, S_X1_e2,N);

m_X1_e3 = [0; 0];
S_X1_e3 = 2*[1 0; 0 1];
X1_e3 = mvnrnd(m_X1_e3, S_X1_e3,N);

m_X1_e4 = [0; 0];
S_X1_e4 = 3*[1 0; 0 1];
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

for i = 1:100
    subplot(10,10,i)
    plot(X1{i}(:,1),X1{i}(:,2),'+')
    hold on;
end
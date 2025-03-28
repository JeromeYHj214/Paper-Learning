%----------------------------------------------------
% 由位置X1；偏差向量e2、e3、e4；观测噪声d1、d2、d3、d3.
%----------------------------------------------------
clc;clear;close;
feature_dimension = 2;
N = 100;
%% 四点链式结构
m_x1 = [4 16];  S_x1 = 0.01 * eye(2);
m_e2 = [4 -4];  S_e2 = 0.01 * eye(2);
m_e3 = [4 -4];  S_e3 = 0.01 * eye(2);
m_e4 = [4 -4];  S_e4 = 0.01 * eye(2);
m_n1 = [0 0];   S_n1 = 0.01 * eye(2);
m_n2 = [0 0];   S_n2 = 0.01 * eye(2);
m_n3 = [0 0];   S_n3 = 0.01 * eye(2);
m_n4 = [0 0];   S_n4 = 0.01 * eye(2);
X1 = cell(1,N);
X1_ori = cell(1,N);
x1 = mvnrnd(m_x1, S_x1, N);
e2 = mvnrnd(m_e2, S_e2, N);
e3 = mvnrnd(m_e3, S_e3, N);
e4 = mvnrnd(m_e4, S_e4, N);
n1 = mvnrnd(m_n1, S_n1, N);
n2 = mvnrnd(m_n2, S_n2, N);
n3 = mvnrnd(m_n3, S_n3, N);
n4 = mvnrnd(m_n4, S_n4, N);
x2 = x1 + e2;
x3 = x2 + e3;
x4 = x3 + e4;
x1_n = x1 + n1;
x2_n = x2 + n2;
x3_n = x3 + n3;
x4_n = x4 + n4;
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
save('data2.mat','X1')
% %% 判断大小
% ct = 0.1;
% %yz = 2*ct*(log(1/pi)-log(ct)+log(2*30/3))   %强度二和强度一
% %yz = 2*ct*(log(1.5/pi)-log(ct)+log(3*(25.5/3)/2))   %强度三和强度二
% yz = 2*ct*(log(2/pi)-log(ct)+log(4*(71.4/25.5)))   %强度三和强度二
% count = zeros(1,4);
% for i = 1:100
%     dis = (X1_ori{i}(1,1) - 4)^2 + (X1_ori{i}(1,2) - 16)^2;
%     if dis < yz
%         count(1) = count(1) + 1;
%     end
% end
% 
% for i = 1:100
%     dis = (X1_ori{i}(2,1) - 8)^2 + (X1_ori{i}(2,2) - 12)^2;
%     if dis < yz
%         count(2) = count(2) + 1;
%     end
% end
% 
% for i = 1:100
%     dis = (X1_ori{i}(3,1) - 12)^2 + (X1_ori{i}(3,2) - 8)^2;
%     if dis < yz
%         count(3) = count(3) + 1;
%     end
% end
% 
% for i = 1:100
%     dis = (X1_ori{i}(4,1) - 16)^2 + (X1_ori{i}(4,2) - 4)^2;
%     if dis < yz
%         count(4) = count(4) + 1;
%     end
% end
% count
%% 似然值
% all_val_lh = zeros(1,100);
% for i = 1:100
%     l = size(X1{i},1);
%     if l==1
%         val = 0.05/4*factorial(l);
%         
%         for j = 1:l
%             if X1{i}(j,3) == 1
%                 val = val * 1/(2*pi*det(S_d1)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1)*S_d1^-1*(X1{i}(j,1:2)-m_x1)');
%             elseif X1{i}(j,3) == 2
%                 val = val * 1/(2*pi*det(S_d2)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2)*S_d2^-1*(X1{i}(j,1:2)-m_x1-m_e2)');
%             elseif X1{i}(j,3) == 3
%                 val = val * 1/(2*pi*det(S_d3)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)*S_d3^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)');
%             else
%                 val = val * 1/(2*pi*det(S_d4)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)*S_d4^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)');
%             end
%         end
%         
%     elseif l==2
%         val = 0.1/6*factorial(l);
%         
%         for j = 1:l
%             if X1{i}(j,3) == 1
%                 val = val * 1/(2*pi*det(S_d1)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1)*S_d1^-1*(X1{i}(j,1:2)-m_x1)');
%             elseif X1{i}(j,3) == 2
%                 val = val * 1/(2*pi*det(S_d2)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2)*S_d2^-1*(X1{i}(j,1:2)-m_x1-m_e2)');
%             elseif X1{i}(j,3) == 3
%                 val = val * 1/(2*pi*det(S_d3)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)*S_d3^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)');
%             else
%                 val = val * 1/(2*pi*det(S_d4)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)*S_d4^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)');
%             end
%         end
%     
%     elseif l==3
%         val = 0.15/4*factorial(l);
%         
%         for j = 1:l
%             if X1{i}(j,3) == 1
%                 val = val * 1/(2*pi*det(S_d1)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1)*S_d1^-1*(X1{i}(j,1:2)-m_x1)');
%             elseif X1{i}(j,3) == 2
%                 val = val * 1/(2*pi*det(S_d2)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2)*S_d2^-1*(X1{i}(j,1:2)-m_x1-m_e2)');
%             elseif X1{i}(j,3) == 3
%                 val = val * 1/(2*pi*det(S_d3)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)*S_d3^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)');
%             else
%                 val = val * 1/(2*pi*det(S_d4)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)*S_d4^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)');
%             end
%         end
%         
%     else
%         val = 0.7*factorial(l);
%         
%        for j = 1:l
%             if X1{i}(j,3) == 1
%                 val = val * 1/(2*pi*det(S_d1)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1)*S_d1^-1*(X1{i}(j,1:2)-m_x1)');
%             elseif X1{i}(j,3) == 2
%                 val = val * 1/(2*pi*det(S_d2)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2)*S_d2^-1*(X1{i}(j,1:2)-m_x1-m_e2)');
%             elseif X1{i}(j,3) == 3
%                 val = val * 1/(2*pi*det(S_d3)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)*S_d3^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3)');
%             else
%                 val = val * 1/(2*pi*det(S_d4)^0.5)*exp(-1/2*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)*S_d4^-1*(X1{i}(j,1:2)-m_x1-m_e2-m_e3-m_e4)');
%             end
%         end
%         
%     end
%     all_val_lh(i) = val;
% end
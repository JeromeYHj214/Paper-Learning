close all;clc;clear;

%num 为点模式个数，100个用作训练，40个用作测试
num_X1 = 140;

%lambda 为点模式的基数分布参数，符合泊松分布
lambda_X1 = 40;

%alpha mu sigma为点模式的特征分布参数，符合高斯分布
mu_X1_x1 = [-4 -4];
mu_X1_x2 = [-4 -4];
mu_X1_x3 = [2 2];
mu_X1_x4 = [-1 -6];
mu_X1 = [mu_X1_x1;mu_X1_x2;mu_X1_x3;mu_X1_x4];
sigma_X1_x1 = [1 0.5; 0.5 1];
sigma_X1_x2 = [4 2; 2 4];
sigma_X1_x3 = [2 -1; -1 2];
sigma_X1_x4 = [0.125 0; 0 0.125];
sigma_X1 = zeros(2,2,4);
sigma_X1(:,:,1) = sigma_X1_x1;
sigma_X1(:,:,2) = sigma_X1_x2;
sigma_X1(:,:,3) = sigma_X1_x3;
sigma_X1(:,:,4) = sigma_X1_x4;
alpha_X1 = [0.3 0.3 0.3 0.1];

%X1 用来保存数据
X1 = cell(2, num_X1);

%X1_cad_ori 记录X1的真实基数分布
X1_cad_ori = random('Poisson',lambda_X1,1,num_X1);

%X1_cad j记录X1生成数据的基数分布
X1_cad = zeros(1,num_X1);

%X1_feat 记录X1的特征分布
X1_feat = cell(1,num_X1);

pt2_train = [];
pt2_test = [];

for i = 1:num_X1
    R = fix(alpha_X1 * X1_cad_ori(i));
    count = sum(R);
    X1_cad(i) = count;
    X1{1,i} = count;
    X1_feat{i} = mvnrnd(mu_X1_x1, sigma_X1_x1, R(1));
    X1_feat{i} = [X1_feat{i};mvnrnd(mu_X1_x2, sigma_X1_x2, R(2))];
    X1_feat{i} = [X1_feat{i};mvnrnd(mu_X1_x3, sigma_X1_x3, R(3))];
    X1_feat{i} = [X1_feat{i};mvnrnd(mu_X1_x4, sigma_X1_x4, R(4))];
    X1_feat{i}(1:R(1),3) = 1;
    X1_feat{i}(R(1)+1:R(1)+R(2),3) = 2;
    X1_feat{i}(R(1)+ R(2)+1:R(1)+R(2)+R(3),3) = 3;
    X1_feat{i}(R(1)+ R(2)+R(3)+1:R(1)+R(2)+R(3)+R(4),3) = 4;
    X1{2,i} = X1_feat{i}';
end

for i = 1:100
    pt2_train = [pt2_train X1{2,i}(1:2,:)];
end

for i = 101:num_X1
    pt2_test = [pt2_test X1{2,i}(1:2,:)];
end
figure(1);
plot(pt2_train(1,:), pt2_train(2,:), '.');
%axis([min(pt1_train(1,:)) max(pt1_train(1,:)) min(pt1_train(2,:)) max(pt1_train(2,:))]);
hold on;
save('ex2_X1.mat','mu_X1','sigma_X1','alpha_X1','X1_cad_ori','X1_feat','X1','pt2_train','pt2_test');
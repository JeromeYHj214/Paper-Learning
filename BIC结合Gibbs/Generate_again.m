close all;clc;clear;

%num 为点模式个数，100个用作训练，40个用作测试
num_X2 = 140;

%lambda 为点模式的基数分布参数，符合泊松分布
lambda_X2 = 20;

%alpha mu sigma为点模式的特征分布参数，符合高斯分布
mu_X2_x1 = [4 4];
mu_X2_x2 = [4 10];
mu_X2_x3 = [8 6];
mu_X2_x4 = [7 7];
mu_X2 = [mu_X2_x1;mu_X2_x2;mu_X2_x3;mu_X2_x4];
sigma_X2_x1 = [0.8 0; 0 0.8];
sigma_X2_x2 = [1.2 0.2; 0.2 1.2];
sigma_X2_x3 = [1.5 0; 0 1.5];
sigma_X2_x4 = [0.5 0; 0 0.5];
sigma_X2 = zeros(2,2,4);
sigma_X2(:,:,1) = sigma_X2_x1;
sigma_X2(:,:,2) = sigma_X2_x2;
sigma_X2(:,:,3) = sigma_X2_x3;
sigma_X2(:,:,4) = sigma_X2_x4;
alpha_X2 = [1/4 1/4 1/4 1/4];

%X2 用来保存数据
X2 = cell(2, num_X2);

%X2_cad_ori 记录X2的真实基数分布
X2_cad_ori = random('Poisson',lambda_X2,1,num_X2);

%X2_cad j记录X2生成数据的基数分布
X2_cad = zeros(1,num_X2);

%X2_feat 记录X2的特征分布
X2_feat = cell(1,num_X2);

pt2_train = [];
pt2_test = [];

for i = 1:num_X2
    R = fix(alpha_X2 * X2_cad_ori(i));
    count = sum(R);
    X2_cad(i) = count;
    X2{1,i} = count;
    X2_feat{i} = mvnrnd(mu_X2_x1, sigma_X2_x1, R(1));
    X2_feat{i} = [X2_feat{i};mvnrnd(mu_X2_x2, sigma_X2_x2, R(2))];
    X2_feat{i} = [X2_feat{i};mvnrnd(mu_X2_x3, sigma_X2_x3, R(3))];
    X2_feat{i} = [X2_feat{i};mvnrnd(mu_X2_x4, sigma_X2_x4, R(4))];
    X2_feat{i}(1:R(1),3) = 1;
    X2_feat{i}(R(1)+1:R(1)+R(2),3) = 2;
    X2_feat{i}(R(1)+ R(2)+1:R(1)+R(2)+R(3),3) = 3;
    X2_feat{i}(R(1)+ R(2)+R(3)+1:R(1)+R(2)+R(3)+R(4),3) = 4;
    X2{2,i} = X2_feat{i}';
end

for i = 1:100
    pt2_train = [pt2_train X2{2,i}(1:2,:)];
end

for i = 101:num_X2
    pt2_test = [pt2_test X2{2,i}(1:2,:)];
end
figure(1);
plot(pt2_train(1,:), pt2_train(2,:), '.');
%axis([min(pt1_train(1,:)) max(pt1_train(1,:)) min(pt1_train(2,:)) max(pt1_train(2,:))]);
hold on;
save('X2.mat','mu_X2','sigma_X2','alpha_X2','X2_cad_ori','X2_feat','X2','pt2_train','pt2_test');
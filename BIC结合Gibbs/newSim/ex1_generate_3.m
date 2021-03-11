close all;clc;clear;

mu_X1 = [5 5; 5 15; 9 9];
sigma_X1(:,:,1) = [1 0; 0 1]; 
sigma_X1(:,:,2) = [2 -0.5; -0.5 2];
sigma_X1(:,:,3) = [2 0.5; 0.5 2];
alpha_X1 = [1/3 1/3 1/3];
gm_X1 = gmdistribution(mu_X1,sigma_X1,alpha_X1);

%num 为点模式个数，100个用作训练，40个用作测试
num_X1 = 140;
%lambda 为点模式的基数分布参数，符合泊松分布
lambda_X1 = 39;


%X1 用来保存数据
X1 = cell(2, num_X1);
%X1_cad_ori 记录X1的真实基数分布
X1_cad_ori = random('Poisson',lambda_X1,1,num_X1);
%X1_cad j记录X1生成数据的基数分布
X1_cad = zeros(1,num_X1);
%X1_feat 记录X1的特征分布
X1_feat = cell(1,num_X1);

pt1_train = [];
pt1_test = [];
pt1 = [];

for i = 1:num_X1
    [x1,compIdx] = random(gm_X1,X1_cad_ori(i));
    X1_cad(i) = size(x1,1);
    X1_feat{i} = x1;
    X1{1,i} = X1_cad(i);
    X1{2,i} = x1';
    pt1 = [pt1 X1{2,i}];
end

for i = 1:100
    pt1_train = [pt1_train X1{2,i}(1:2,:)];
end

for i = 101:num_X1
    pt1_test = [pt1_test X1{2,i}(1:2,:)];
end

figure(1);
plot(pt1(1,:), pt1(2,:), '.');
axis([min(pt1(1,:)) max(pt1(1,:)) min(pt1(2,:)) max(pt1(2,:))]);
hold on;
figure(2);
aa = min(X1_cad(1:100)):1:max(X1_cad(1:100));
[bb ,cc] = hist(X1_cad(1:100),aa);
bb = bb /100;
bar(cc,bb,1);
save('ex3_X3.mat','mu_X1','sigma_X1','alpha_X1','X1_cad_ori','X1_feat','X1','pt1_train','pt1_test','X1_cad');

close all;clc;clear;

%num Ϊ��ģʽ������100������ѵ����40����������
num_X1 = 140;

%lambda Ϊ��ģʽ�Ļ����ֲ����������ϲ��ɷֲ�
lambda_X1 = 60;

%alpha mu sigmaΪ��ģʽ�������ֲ����������ϸ�˹�ֲ�
mu_X1_x1 = [-4 -4];
mu_X1_x2 = [-4 -4];
mu_X1_x3 = [6 6];
mu_X1_x4 = [6 6];
mu_X1_x5 = [5 -6];
mu_X1 = [mu_X1_x1;mu_X1_x2;mu_X1_x3;mu_X1_x4;mu_X1_x5];
sigma_X1_x1 = [1 0.5; 0.5 1];
sigma_X1_x2 = [6 -2; -2 6];
sigma_X1_x3 = [1 0.5; 0.5 1];
sigma_X1_x4 = [6  -2; -2 6];
sigma_X1_x5 = [1 0; 0 1];
sigma_X1 = zeros(2,2,5);
sigma_X1(:,:,1) = sigma_X1_x1;
sigma_X1(:,:,2) = sigma_X1_x2;
sigma_X1(:,:,3) = sigma_X1_x3;
sigma_X1(:,:,4) = sigma_X1_x4;
sigma_X1(:,:,5) = sigma_X1_x5;
alpha_X1 = [0.2 0.2 0.2 0.2 0.2];

%X1 ������������
X1 = cell(2, num_X1);

%X1_cad_ori ��¼X1����ʵ�����ֲ�
X1_cad_ori = random('Poisson',lambda_X1,1,num_X1);

%X1_cad j��¼X1�������ݵĻ����ֲ�
X1_cad = zeros(1,num_X1);

%X1_feat ��¼X1�������ֲ�
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
    X1_feat{i} = [X1_feat{i};mvnrnd(mu_X1_x5, sigma_X1_x5, R(5))];
    X1_feat{i}(1:R(1),3) = 1;
    X1_feat{i}(R(1)+1:R(1)+R(2),3) = 2;
    X1_feat{i}(R(1)+ R(2)+1:R(1)+R(2)+R(3),3) = 3;
    X1_feat{i}(R(1)+ R(2)+R(3)+1:R(1)+R(2)+R(3)+R(4),3) = 4;
    X1_feat{i}(R(1)+ R(2)+R(3)+R(4)+1:R(1)+R(2)+R(3)+R(4)+R(5),3) = 5;
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

%%
%load ex2_X1.mat ;
figure(2);
set(gcf,'color','white');
plot(pt2_train(1,1:3000), pt2_train(2,1:3000),'r.');
hold on;
for m=1:5
    [ex1,ey11,ex2,ey12] = Get_Ellipse(mu_X1(m,:),sigma_X1(:,:,m));
    plot(ex1,ey11,'b',ex2,ey12,'b');
end
title('ģ���������ռ����ʵ�ֲ�');
saveas(gcf, 'ex2_realDis', 'png');

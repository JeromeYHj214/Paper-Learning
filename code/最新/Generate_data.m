close all;clc;clear;

%num Ϊ��ģʽ������100������ѵ����40����������
num_X1 = 140;
num_X2 = 140;

%lambda Ϊ��ģʽ�Ļ����ֲ����������ϲ��ɷֲ�
lambda_X1 = 15;
lambda_X2 = 24;

%mu sigmaΪ��ģʽ�������ֲ����������ϸ�˹�ֲ�
mu_X1_x1 = [4 4];
mu_X1_x2 = [4 10];
mu_X1_x3 = [8 6];
sigma_X1_x1 = [0.8 0; 0 0.8];
sigma_X1_x2 = [1.2 0.2; 0.2 1.2];
sigma_X1_x3 = [1.5 0; 0 1.5];

%X1 X2������������
X1 = cell(2, num_X1);
X2 = cell(2, num_X2);

X1_cad = random('Poisson',lamda_X1);
for i = 1:num_X1
    X1{1,i} = X1_cad(i);
end

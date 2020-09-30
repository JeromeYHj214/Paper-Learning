clc;clear;close all;
load('fangzhen.mat');
target = 3;
sensor = 10;
range = [-1000 1000;-1000 1000];
lambda = targe * fix(sensor/3);
Nc = poissrnd(lambda);        
Zc = repmat(range(:,1),[1,Nc])+(range(1,2)-range(1,1))*rand(2,Nc);
Sigma = [100 0;0 100];
%------target变化需要修改--------
%-------用第四步作为参考---------
mu1 = [X1(1,4) X1(3,4)];
mu2 = [X2(1,4) X2(3,4)];
mu3 = [X3(1,4) X3(3,4)];
Z1 = mvnrnd(mu1, Sigma, 10)';
Z2 = mvnrnd(mu2, Sigma, 10)';
Z3 = mvnrnd(mu3, Sigma, 10)';
Z_real = [Z1 Z2 Z3 Zc];
prev_mu = [Zk(:,4), Zk(:,54) Zk(:,104)]
%-------------------------------


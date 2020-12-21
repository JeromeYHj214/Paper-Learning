close all;clear all;clc;

load T15.mat;
X = T15_feat_pca;

load T15Model.mat;


plot(X(:,1),X(:,2),'ko')
title('Scatter Plot')
xlim([min(X(:,1))-50 max(X(:,1))+50]) % Make axes have the same scale
ylim([min(X(:,2))-50 max(X(:,2))+50])
hold on
h = ezcontour(@(x,y)pdf(BestModelBIC,[x y]),xlim,ylim);      
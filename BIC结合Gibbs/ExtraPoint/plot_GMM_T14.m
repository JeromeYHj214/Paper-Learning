close all;clear all;clc;

load T14.mat;
X = T14_feat_pca;

load T14Model.mat;


plot(X(:,1),X(:,2),'k.')
title('Scatter Plot')
xlim([min(X(:,1))-50 max(X(:,1))+50]) % Make axes have the same scale
ylim([min(X(:,2))-50 max(X(:,2))+50])
hold on
h = ezcontour(@(x,y)pdf(BestModelBIC,[x y]),xlim,ylim);     
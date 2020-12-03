close all;clear all;clc;
num = 500000;lam = 25;
sample = poissrnd(lam,num,1);
X = min(sample):1:max(sample);
x = min(sample):max(sample);
px= poisspdf(x,25);
% figure;
% hist(sample,X);
% title('Random Numbers of Poisson distribute (using hist)');
% h=findobj(gca,'Type','patch');
% set(h,'facecolor','c');
figure;
[counts,binloca]=hist(sample,X);
counts=counts/num;
bar(binloca,counts,1);
title('Random Numbers of Poisson distribute (using bar)');
hold on
plot(x,px,'b.-')
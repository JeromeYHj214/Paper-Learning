close all;clear all;clc;
num = 500000;lam = 60;
lam_learn = 58.25
sample = poissrnd(lam,num,1);
sample_learn = poissrnd(lam_learn,num,1);
X = min(sample):1:max(sample);
X_learn = min(sample_learn):1:max(sample_learn);
% x = min(sample):max(sample);
% px= poisspdf(x,25);
% figure;
% hist(sample,X);
% title('Random Numbers of Poisson distribute (using hist)');
% h=findobj(gca,'Type','patch');
% set(h,'facecolor','c');
figure;
[counts,binloca]=hist(sample,X);
counts=counts/num;

[counts_learn,binloca_learn]=hist(sample_learn,X_learn);
counts_learn=counts_learn/num;

bar(binloca,counts,1,'FaceColor','k');
hold on;
bar(binloca_learn,counts_learn,1,'FaceColor','w');
%title('Random Numbers of Poisson distribute (using bar)');
title('Poisson Distribute');
legend('real model','learn model')
hold on
set(gcf,'color','white');
% plot(x,px,'b.-')
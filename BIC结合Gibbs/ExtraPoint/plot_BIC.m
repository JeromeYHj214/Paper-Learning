close all;clear all;clc;

% load T20model.mat ;
% figure(1);
% set(gcf,'color','white');
% plot(AIC,'-*k');
% hold on;
% plot(BIC,'-sk');
% legend('AIC优化准则','BIC优化准则')
% xlabel('分布元个数');
% ylabel('优化准则值');

load T20model.mat ;
figure(1);
set(gcf,'color','white');
plot(BIC,'-sk');
xlabel('分布元个数');
ylabel('优化准则值');
hold on ;
load T14model.mat ;
plot(BIC,'-*k');
hold on;
load T15model.mat ;
plot(BIC(1:10),'-ok');
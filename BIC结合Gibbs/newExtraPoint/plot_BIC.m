close all;clear all;clc;

% load T20model.mat ;
% figure(1);
% set(gcf,'color','white');
% plot(AIC,'-*k');
% hold on;
% plot(BIC,'-sk');
% legend('AIC�Ż�׼��','BIC�Ż�׼��')
% xlabel('�ֲ�Ԫ����');
% ylabel('�Ż�׼��ֵ');

load T20model.mat ;
figure(1);
set(gcf,'color','white');
plot(BIC,'-sk');
xlabel('�ֲ�Ԫ����');
ylabel('�Ż�׼��ֵ');
hold on ;
load T14model.mat ;
plot(BIC,'-*k');
hold on;
load T15model.mat ;
plot(BIC(1:10),'-ok');
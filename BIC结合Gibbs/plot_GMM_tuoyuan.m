close all;clear all;clc;
load ex2_X1.mat ;
load ex2_X1_para_1.mat;
figure(2);
set(gcf,'color','white');
mu_X2 = canshu{2,4}';
sigma_X2 = canshu{3,4};
m=1;
% [ex1,ey11,ex2,ey21] = Get_Ellipse(mu_X1(m,:),sigma_X1(:,:,m));
% [ex3,ey31,ex4,ey41] = Get_Ellipse(mu_X2(m,:),sigma_X2(:,:,m));
% plot(ex1,ey11,'k',ex3,ey31,'--k');  
% hold on
plot(pt2_train(1,1:1500), pt2_train(2,1:1500),'.k');
hold on
% plot(ex2,ey21,'k',ex4,ey41,'--k');
% hold on
% for m=2:5
%     [ex1,ey11,ex2,ey12] = Get_Ellipse(mu_X1(m,:),sigma_X1(:,:,m));
%     plot(ex1,ey11,'k',ex2,ey12,'k');
%     hold on;
% end
% 
% for m=2:5
%     [ex3,ey31,ex4,ey42] = Get_Ellipse(mu_X2(m,:),sigma_X2(:,:,m));
%     plot(ex3,ey31,'--k',ex4,ey42,'--k');
% end

title('Feature Distribution');
ylabel('X');
xlabel('Y');
%legend('real model','learn model','data');
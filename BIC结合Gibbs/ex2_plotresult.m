close all;clear all;clc;
load ex2_X1.mat;
real_mu_X1 = mu_X1;
real_sigma_X1 = sigma_X1;
data = [];
for i = 1:140
    data = [data X1{2,i}];
end
load ex2_X1_para_1.mat;
learning_mu_X1 = canshu{2,4}';
learning_sigma_X1 = canshu{3,4};
learning_alpha_X1 = canshu{1,4}';

figure;
set(gcf,'color','white');
plot(pt2_train(1,1:3000), pt2_train(2,1:3000),'.k');
%axis([min(data(1,:)) max(data(1,:)) min(data(2,:)) max(data(2,:))]); 
ylabel('X');
xlabel('Y');
hold on;
for i = 1:5
  [ex1,ey11,ex2,ey12] = Get_Ellipse(real_mu_X1(i,:),real_sigma_X1(:,:,i));  
  plot(ex1,ey11,'g',ex2,ey12,'g','LineWidth',2);
end

for i = 1:5
  [ex1,ey11,ex2,ey12] = Get_Ellipse(learning_mu_X1(i,:),learning_sigma_X1(:,:,i));  
  plot(ex1,ey11,'r',ex2,ey12,'r','LineWidth',2);
end
title('Feature Space');

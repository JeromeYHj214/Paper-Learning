close all;clear all;clc;

load ex3_X1.mat
x1 = X1;
x1_card = X1_cad;
x1_feat = [pt1_train pt1_test];
load ex3_X2.mat
x2 = X1;
x2_card = X1_cad;
x2_feat = [pt1_train pt1_test];
load ex3_X3.mat
x3 = X1;
x3_card = X1_cad;
x3_feat = [pt1_train pt1_test];

%% 描绘特征分布
% aa = 500;
% figure;
% plot(x1_feat(1,1:aa),x1_feat(2,1:aa),'.r');
% hold on
% plot(x2_feat(1,1:aa),x2_feat(2,1:aa),'ob');
% hold on
% plot(x3_feat(1,1:aa),x3_feat(2,1:aa),'+g');
% legend('类一','类二','类三');
% 
% % 描绘基数分布 hist方法
% figure;
% x1_rand = min(x1_card):1:max(x1_card);
% [x1_count, x1_binloca] = hist(x1_card,x1_rand);
% x1_count = x1_count/140;
% bar(x1_binloca,x1_count,1,'FaceColor','r');
% hold on;
% 
% x2_rand = min(x2_card):1:max(x2_card);
% [x2_count, x2_binloca] = hist(x2_card,x2_rand);
% x2_count = x2_count/140;
% bar(x2_binloca,x2_count,1,'FaceColor','b');
% hold on;
% 
% x3_rand = min(x3_card):1:max(x3_card);
% [x3_count, x3_binloca] = hist(x3_card,x3_rand);
% x3_count = x3_count/140;
% bar(x3_binloca,x3_count,1,'FaceColor','g');
% legend('类一','类二','类三');
%% 描绘基数分布 自己的方法
max_val = max([x1_card x2_card x3_card]);
x1_ratio = zeros(1,max_val);
x2_ratio = zeros(1,max_val);
x3_ratio = zeros(1,max_val);
for i = 1:max_val
    a = length(find(x1_card == i));
    b = length(find(x2_card == i));
    c = length(find(x3_card == i));
    x1_ratio(i) = a / 140;
    x2_ratio(i) = b / 140;
    x3_ratio(i) = c / 140;
end
bar_set=zeros(max_val,3);
for i = 1:max_val
    bar_set(i,1)=x1_ratio(i);
    bar_set(i,2)=x2_ratio(i);
    bar_set(i,3)=x3_ratio(i);
end
figure;
set(gcf,'color','white');
b = bar(bar_set,4);
axis([5 55,-inf,inf]);
color = ['r','b','g'];
set(b(1),'FaceColor',color(1));
set(b(2),'FaceColor',color(2));
set(b(3),'FaceColor',color(3));
legend('类一','类二','类三');
ylabel('Frequency');
xlabel('Cardinality n');
title('Cardinality histogram');
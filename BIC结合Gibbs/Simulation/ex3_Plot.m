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
aa = 500;
figure;
subplot(1,2,2);
set(gcf,'color','white');
plot(x1_feat(1,1:aa),x1_feat(2,1:aa),'.r');
hold on
plot(x2_feat(1,1:aa),x2_feat(2,1:aa),'+b');
hold on
plot(x3_feat(1,1:aa),x3_feat(2,1:aa),'og');
l1 = legend('类一','类二','类三');
set(l1,'FontSize',15)
ylabel('Y','FontSize',15);
xlabel({'X';'（b）数据集的特征分布'},'FontSize',15);
% title('（b）数据集的特征分布','FontSize',15);
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
subplot(1,2,1);
set(gcf,'color','white');
b = bar(bar_set,4);
axis([5 55,-inf,inf]);
color = ['r','b','g'];
set(b(1),'FaceColor','none','EdgeColor','r','LineStyle',':');
set(b(2),'FaceColor','none','EdgeColor','g','LineStyle','-');
set(b(3),'FaceColor','none','EdgeColor','b','LineStyle','--');
l1 = legend('类一','类二','类三');
set(l1,'FontSize',15)
ylabel('频率','FontSize',15);
xlabel({'基数 n';'（a）数据集的基数分布'},'FontSize',15);
% title('（a）数据集的基数分布','FontSize',15);
% title('Cardinality histogram');
%%
aa = 3;
bb = 3;
cc = 3;
figure;
set(gcf,'color','white');
load ex3_X1_model.mat;
gm1 = GMModels{aa};
[x1,x2] = meshgrid(0:0.01:14,2:0.01:20);
contour(x1,x2,reshape(pdf(gm1,[x1(:) x2(:)]),size(x1,1),size(x1,2)),5,':r');
ylabel('Y','FontSize',15);
xlabel('X','FontSize',15);
hold on;

load ex3_X2_model.mat;
gm2 = GMModels{bb};
contour(x1,x2,reshape(pdf(gm2,[x1(:) x2(:)]),size(x1,1),size(x1,2)),5,'--g');
hold on;

load ex3_X3_model.mat;
gm3 = GMModels{cc};
contour(x1,x2,reshape(pdf(gm3,[x1(:) x2(:)]),size(x1,1),size(x1,2)),5,'-b');
hold on;
l1 = legend('类一','类二','类三');
set(l1,'FontSize',15)
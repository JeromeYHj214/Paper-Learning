close all;clear all;clc;
load T14.mat ;
load T15.mat ;
load T20.mat ;
figure(1);
subplot(1,2,2);
% plot(T14_feat_pca(1:1000,1),T14_feat_pca(1:1000,2),'.r');
% hold on
% plot(T15_feat_pca(1:600,1),T15_feat_pca(1:600,2),'+b');
% hold on
% plot(T20_feat_pca(1:400,1),T20_feat_pca(1:400,2),'og');

% plot(T14_feat_pca(1:1000,1),T14_feat_pca(1:1000,2),'.r');
% hold on
% plot(T15_feat_pca(1:200,1),T15_feat_pca(1:200,2),'.b');
% hold on
% plot(T20_feat_pca(1:700,1),T20_feat_pca(1:700,2),'.g');

plot(T14_feat_pca(1:1000,1),T14_feat_pca(1:1000,2),'.r');
hold on
plot(T15_feat_pca(1:200,1),T15_feat_pca(1:200,2),'.b');
hold on
plot(T20_feat_pca(1:500,1),T20_feat_pca(1:500,2),'.g');

set(gcf,'color','white');
ylabel('Y','FontSize',15);
%xlabel({'X';'(b)特征分布'},'FontSize',15);
xlabel('X','FontSize',15);
% title('Feature Distribution');
l1 = legend('T14','T15','T20');
set(l1,'FontSize',15);
title('（b）','position',[-310,300]);
set(gca,'XLim',[-300 300])
set(gca,'YLim',[-300 300])

subplot(1,2,1);
T14_X = min(T14_card):1:max(T14_card);
[T14_counts,T14_binloca]=hist(T14_card,T14_X);
T14_counts=T14_counts / 40;
% bar(T14_binloca(1:280),T14_counts(1:280),1,'FaceColor','b');
% bar(T14_binloca,T14_counts,1,'FaceColor','none','EdgeColor','r','LineStyle','-');
% hold on;
bar(T14_binloca,T14_counts,1,'FaceColor','r','EdgeColor','none');
hold on;

T15_X = min(T15_card):1:max(T15_card);
[T15_counts,T15_binloca]=hist(T15_card,T15_X);
T15_counts=T15_counts / 40;
% bar(T15_binloca,T15_counts,1,'FaceColor','none','EdgeColor','b','LineStyle','-.');
% hold on;
bar(T15_binloca,T15_counts,1,'FaceColor','b','EdgeColor','none');
hold on;

T20_X = min(T20_card):1:max(T20_card);
[T20_counts,T20_binloca]=hist(T20_card,T20_X);
T20_counts=T20_counts / 40;
% bar(T20_binloca,T20_counts,1,'FaceColor','none','EdgeColor','g','LineStyle','--');
bar(T20_binloca,T20_counts,1,'FaceColor','g','EdgeColor','none');
 set(gca,'XLim',[0 200])
ylabel('Frequency','FontSize',15);
%xlabel({'基数 n';'(a)特征分布'},'FontSize',15);
xlabel('Cardinality n','FontSize',15);
%title('Cardinality histogram');
title('（a）','position',[-10,0.13]);
l1 = legend('T14','T15','T20');
set(l1,'FontSize',15);
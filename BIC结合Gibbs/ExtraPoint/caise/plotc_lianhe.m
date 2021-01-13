close all;clear all;clc;

figure;
set(gcf,'color','white');
subplot(1,3,2);
load T14cmodel.mat;
gm1 = BestModelBIC;
[x1,x2] = meshgrid(-400:1:400,-300:1:250);
contour(x1,x2,reshape(pdf(gm1,[x1(:) x2(:)]),size(x1,1),size(x1,2)),16,'-r');
ylabel('Y','FontSize',15);
xlabel('X','FontSize',15);
hold on;

load T15cmodel.mat;
gm2 = BestModelBIC;
contour(x1,x2,reshape(pdf(gm2,[x1(:) x2(:)]),size(x1,1),size(x1,2)),16,'-b');
hold on;

load T20cmodel.mat;
gm3 =  BestModelBIC;
contour(x1,x2,reshape(pdf(gm3,[x1(:) x2(:)]),size(x1,1),size(x1,2)),16,'-g');
hold on;
l1 = legend('T14','T15','T20');
set(l1,'FontSize',15)
set(gca,'YLim',[-245 250])

subplot(1,3,1)
num = 500000;
all_pios = [135.79,16.41,53.79];
sample1 = poissrnd(all_pios(1),num,1);
sample2 = poissrnd(all_pios(2),num,1);
sample3 = poissrnd(all_pios(3),num,1);
X1 = min(sample1):1:max(sample1);
X2 = min(sample2):1:max(sample2);
X3 = min(sample3):1:max(sample3);
[counts1,binloca1]=hist(sample1,X1);
counts1=counts1/num;

[counts2,binloca2]=hist(sample2,X2);
counts2=counts2/num;

[counts3,binloca3]=hist(sample3,X3);
counts3=counts3/num;

% bar(binloca1,counts1,1,'FaceColor','none','EdgeColor','r','LineStyle','-');
% hold on;
% bar(binloca2,counts2,1,'FaceColor','none','EdgeColor','b','LineStyle','-.');
% hold on;
% bar(binloca3,counts3,1,'FaceColor','none','EdgeColor','g','LineStyle','--');

bar(binloca1,counts1,1,'FaceColor','r');
hold on;
bar(binloca2,counts2,1,'FaceColor','b');
hold on;
bar(binloca3,counts3,1,'FaceColor','g');

l1 = legend('T14','T15','T20');
set(l1,'FontSize',15);
ylabel('Frequency','FontSize',15);
%xlabel({'基数 n';'(a)模型基数分布'},'FontSize',15);
xlabel('Cardinality n','FontSize',15);

subplot(1,3,3);
set(gcf,'color','white');
data = [88.3 94.2];
X = [1 2]
b=bar(X,data);
text(X(1)-0.1,data(1)+3,num2str(round(data(1),1)),'FontSize',15);
text(X(2)-0.1,data(2)+3,num2str(round(data(2),1)),'FontSize',15);
set(gca,'XTickLabel',{'NB Model','Poisson Model'})
set(gca,'YLim',[0 100])
ylabel('Average accuracy(%)','FontSize',15);
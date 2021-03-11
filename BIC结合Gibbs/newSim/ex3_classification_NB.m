%对比了泊松点模型和NB模型的分类效果

close all;clear all;clc;

all_pios = zeros(1,3);
load ex3_X1_model.mat;
all_pios(1) = pios;
gm_x1 = GMModels{1};
load ex3_X2_model.mat;
all_pios(2) = pios;
gm_x2 = GMModels{1};
load ex3_X3_model.mat;
all_pios(3) = pios;
gm_x3 = GMModels{1};

load ex3_X1;
dataX1 = X1;
load ex3_X2;
dataX2 = X1;
load ex3_X3;
dataX3 = X1;

cell_all_data = cell(1,120);
all_data = [dataX1 dataX2 dataX3];
for i = 1:40
   cell_all_data{1,i} =  dataX1{1,i};
   cell_all_data{2,i} =  dataX1{2,i}(1:2,:)';
   cell_all_data{3,i} =  1;
   
   cell_all_data{1,40+i} =  dataX2{1,i};
   cell_all_data{2,40+i} =  dataX2{2,i}(1:2,:)';
   cell_all_data{3,40+i} =  2;
   
   cell_all_data{1,80+i} =  dataX3{1,i};
   cell_all_data{2,80+i} =  dataX3{2,i}(1:2,:)';
   cell_all_data{3,80+i} =  3;
end

pro = zeros(3,120);
NB_pro = zeros(3,120);

num_this = 0;
num_NB = 0;
for i = 1:120
    count = cell_all_data{1,i};
    pro(1,i) = count*log(all_pios(1))-all_pios(1);
    pro(2,i) = count*log(all_pios(2))-all_pios(2);
    pro(3,i) = count*log(all_pios(3))-all_pios(3);
    pro1 = pdf(gm_x1,cell_all_data{2,i});
    pro2 = pdf(gm_x2,cell_all_data{2,i});
    pro3 = pdf(gm_x3,cell_all_data{2,i});
    for j = 1:count
        pro(1,i) = pro(1,i) + log(pro1(j));
        pro(2,i) = pro(2,i) + log(pro2(j));
        pro(3,i) = pro(3,i) + log(pro3(j));
        NB_pro(1,i) = NB_pro(1,i) + log(pro1(j));
        NB_pro(2,i) = NB_pro(2,i) + log(pro2(j));
        NB_pro(3,i) = NB_pro(3,i) + log(pro3(j));
    end
    [m index] = max(pro(:,i));
    [m NB_index] = max(NB_pro(:,i));
    cell_all_data{4,i} = index;
    cell_all_data{5,i} = NB_index;
    
    if(cell_all_data{3,i} == cell_all_data{4,i})
       num_this = num_this + 1; 
    end
    
    if(cell_all_data{3,i} == cell_all_data{5,i})
       num_NB = num_NB + 1; 
    end
end

ratio_num_this = num_this / 120 * 100;
ratio_num_NB = num_NB / 120 * 100;
figure;
subplot(1,3,3);
set(gcf,'color','white');
data = [ratio_num_NB 91.8];
X = [1 2]
b=bar(X,data);
text(X(1)-0.1,data(1)+3,num2str(round(data(1),1)),'FontSize',15);
text(X(2)-0.1,data(2)+3,num2str(round(data(2),1)),'FontSize',15);
set(gca,'XTickLabel',{'NB Model','Poisson Model'})
set(gca,'YLim',[0 100])
ylabel('Average accuracy(%)','FontSize',15);
%xlabel({' ';'(c)分类结果'},'FontSize',15);
% title('Classification Performance');
title('（c）','FontSize',15,'position',[-1,100]);

subplot(1,3,2);
aa = 3;
bb = 3;
cc = 3;
set(gcf,'color','white');
load ex3_X1_model.mat;
gm1 = GMModels{aa};
[x1,x2] = meshgrid(0:0.01:14,2:0.01:20);
contour(x1,x2,reshape(pdf(gm1,[x1(:) x2(:)]),size(x1,1),size(x1,2)),7,'-r','LineWidth',1.5);
ylabel('Y','FontSize',15);
xlabel({'X';'(b)模型特征分布'},'FontSize',15);
hold on;

load ex3_X2_model.mat;
gm2 = GMModels{bb};
%contour(x1,x2,reshape(pdf(gm2,[x1(:) x2(:)]),size(x1,1),size(x1,2)),8,'-.b');
contour(x1,x2,reshape(pdf(gm2,[x1(:) x2(:)]),size(x1,1),size(x1,2)),7,'-b','LineWidth',1.5);
hold on;

load ex3_X3_model.mat;
gm3 = GMModels{cc};
%contour(x1,x2,reshape(pdf(gm3,[x1(:) x2(:)]),size(x1,1),size(x1,2)),8,'--g');
contour(x1,x2,reshape(pdf(gm3,[x1(:) x2(:)]),size(x1,1),size(x1,2)),7,'-g','LineWidth',1.5);
hold on;
l1 = legend('Class 1','Class 2','Class 3');
set(l1,'FontSize',15)
ylabel('Y','FontSize',15);
%xlabel({'X';'（b）数据集的特征分布'},'FontSize',15,'FontName','Arial');
xlabel('X','FontSize',15);
% title('（b）数据集的特征分布','FontSize',15);
title('（b）','FontSize',15,'position',[-1.5,20]);

subplot(1,3,1)
num = 500000;
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

bar(binloca1,counts1,1,'FaceColor','r','EdgeColor','none');
hold on;
bar(binloca2,counts2,1,'FaceColor','b','EdgeColor','none');
hold on;
bar(binloca3,counts3,1,'FaceColor','g','EdgeColor','none');

% l1 = legend('类一','类二','类三')
% set(l1,'FontSize',15);
% ylabel('频率','FontSize',15);
% xlabel({'基数 n';'(a)模型基数分布'},'FontSize',15);

l1 = legend('Class 1','Class 2','Class 3');
set(l1,'FontSize',15)
ylabel('Frequency','FontSize',15);
%xlabel({'基数 n';'（a）数据集的基数分布'},'FontSize',15);
xlabel('Cardinality n','FontSize',15);
% title('（a）数据集的基数分布','FontSize',15);
% title('Cardinality histogram');
title('（a）','FontSize',15,'position',[-1,0.09]);
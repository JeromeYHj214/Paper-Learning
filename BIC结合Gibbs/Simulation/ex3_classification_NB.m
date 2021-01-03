%对比了泊松点模型和NB模型的分类效果

close all;clear all;clc;

all_pios = zeros(1,3);
load ex3_X1_model.mat;
all_pios(1) = pios;
gm_x1 = BestModelBIC;
load ex3_X2_model.mat;
all_pios(2) = pios;
gm_x2 = BestModelBIC;
load ex3_X3_model.mat;
all_pios(3) = pios;
gm_x3 = BestModelBIC;

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
set(gcf,'color','white');
data = [ratio_num_NB ratio_num_this];
X = [1 2]
b=bar(X,data);
text(X(1)-0.1,data(1)+3,num2str(round(data(1),1)),'FontSize',15);
text(X(2)-0.1,data(2)+3,num2str(round(data(2),1)),'FontSize',15);
set(gca,'XTickLabel',{'NB Model','Poisson Model'},'FontSize',15)
set(gca,'YLim',[0 100])
ylabel('准确率(%)','FontSize',15);
% title('Classification Performance');
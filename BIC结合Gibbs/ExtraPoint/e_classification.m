close all;clear all;clc;

%T14标记1；T15标记2；T20标记3；
load T14model.mat;
% gm1 = BestModelBIC; 
gm1 = GMModels{3}; 
load T15model.mat;
% gm2 = BestModelBIC; 
gm2 = GMModels{2}; 
load T20model.mat;
% gm3 = BestModelBIC;
gm3 = GMModels{3}; 

load T14_finalData.mat;
load T15_finalData.mat;
load T20_finalData.mat;

card = zeros(1,3);
%减去10为了学习训练模型的pios；
len = size(cell_T14_point,2)-10;
for i = 1:len
   card(1) = card(1) + cell_T14_point{1,i};
   card(2) = card(2) + cell_T15_point{1,i};
   card(3) = card(3) + cell_T20_point{1,i};
end
card = card ./ len;

%构建测试模型
cell_all_data = [cell_T14_point_text,cell_T15_point_text,cell_T20_point_text];
len_all_data = size(cell_all_data,2);
pro = zeros(3,len_all_data);
NB_pro = zeros(3,len_all_data);

num_this = 0;
num_NB = 0;

for i = 1:len_all_data
    count = cell_all_data{1,i};
    pro(1,i) = count*log(card(1))-card(1);
    pro(2,i) = count*log(card(2))-card(2);
    pro(3,i) = count*log(card(3))-card(3);
    pro1 = pdf(gm1,cell_all_data{2,i});
    pro2 = pdf(gm2,cell_all_data{2,i});
    pro3 = pdf(gm3,cell_all_data{2,i});
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



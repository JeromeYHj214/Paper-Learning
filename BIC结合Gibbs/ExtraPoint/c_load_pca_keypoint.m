close all;clear all;clc;
load T14.mat; load T15.mat; load T20.mat;

%T14标记为1；T15标记为2；T20标记为3；
cell_T14_point = cell(4,40);
cell_T15_point = cell(4,40);
cell_T20_point = cell(4,40);
%保存测试集数据
cell_T14_point_text = cell(4,10);
cell_T15_point_text = cell(4,10);
cell_T20_point_text = cell(4,10);
%保存训练集数据
cell_T14_point_train = cell(4,10);
cell_T15_point_train = cell(4,10);
cell_T20_point_train = cell(4,10);

len = size(cell_T14_point,2);
T14_cumsum = cumsum(T14_card);
T15_cumsum = cumsum(T15_card);
T20_cumsum = cumsum(T20_card);
%对cumsum微调
T14_cumsum = [0 T14_cumsum];
T15_cumsum = [0 T15_cumsum];
T20_cumsum = [0 T20_cumsum];
for i = 1:len
    %保存每张图像的基数信息
    cell_T14_point{1,i} = T14_card(i);
    cell_T15_point{1,i} = T15_card(i);
    cell_T20_point{1,i} = T20_card(i);
    
    %保存每张图像的特征信息
    cell_T14_point{2,i} = T14_feat_pca(T14_cumsum(i)+1:T14_cumsum(i+1),:);
    cell_T15_point{2,i} = T15_feat_pca(T15_cumsum(i)+1:T15_cumsum(i+1),:);
    cell_T20_point{2,i} = T20_feat_pca(T20_cumsum(i)+1:T20_cumsum(i+1),:);
    
    cell_T14_point{3,i} = 1;
    cell_T15_point{3,i} = 2;
    cell_T20_point{3,i} = 3;
end

% %前三十张作为训练
% for i = 1:30
%     %保存每张图像的基数信息
%     cell_T14_point_train{1,i} = cell_T14_point{1,i};
%     cell_T15_point_train{1,i} = cell_T15_point{1,i};
%     cell_T20_point_train{1,i} = cell_T20_point{1,i};
%     
%     %保存每张图像的特征信息
%     cell_T14_point_train{2,i} = cell_T14_point{2,i};
%     cell_T15_point_train{2,i} = cell_T15_point{2,i};
%     cell_T20_point_train{2,i} = cell_T20_point{2,i};
%     
%     cell_T14_point_train{3,i} = cell_T14_point{3,i};
%     cell_T15_point_train{3,i} = cell_T15_point{3,i};
%     cell_T20_point_train{3,i} = cell_T20_point{3,i};
% end
% 
% %最后十张作为测试
% for i = 31:len
%     %保存每张图像的基数信息
%     cell_T14_point_text{1,i-30} = cell_T14_point{1,i};
%     cell_T15_point_text{1,i-30} = cell_T15_point{1,i};
%     cell_T20_point_text{1,i-30} = cell_T20_point{1,i};
%     
%     %保存每张图像的特征信息
%     cell_T14_point_text{2,i-30} = cell_T14_point{2,i};
%     cell_T15_point_text{2,i-30} = cell_T15_point{2,i};
%     cell_T20_point_text{2,i-30} = cell_T20_point{2,i};
%     
%     cell_T14_point_text{3,i-30} = cell_T14_point{3,i};
%     cell_T15_point_text{3,i-30} = cell_T15_point{3,i};
%     cell_T20_point_text{3,i-30} = cell_T20_point{3,i};
% end

%后三十张作为训练
for i = 1:30
    %保存每张图像的基数信息
    cell_T14_point_train{1,i} = cell_T14_point{1,i+10};
    cell_T15_point_train{1,i} = cell_T15_point{1,i+10};
    cell_T20_point_train{1,i} = cell_T20_point{1,i+10};
    
    %保存每张图像的特征信息
    cell_T14_point_train{2,i} = cell_T14_point{2,i+10};
    cell_T15_point_train{2,i} = cell_T15_point{2,i+10};
    cell_T20_point_train{2,i} = cell_T20_point{2,i+10};
    
    cell_T14_point_train{3,i} = cell_T14_point{3,i+10};
    cell_T15_point_train{3,i} = cell_T15_point{3,i+10};
    cell_T20_point_train{3,i} = cell_T20_point{3,i+10};
end

%前十张作为测试
for i = 1:10
    %保存每张图像的基数信息
    cell_T14_point_text{1,i} = cell_T14_point{1,i};
    cell_T15_point_text{1,i} = cell_T15_point{1,i};
    cell_T20_point_text{1,i} = cell_T20_point{1,i};
    
    %保存每张图像的特征信息
    cell_T14_point_text{2,i} = cell_T14_point{2,i};
    cell_T15_point_text{2,i} = cell_T15_point{2,i};
    cell_T20_point_text{2,i} = cell_T20_point{2,i};
    
    cell_T14_point_text{3,i} = cell_T14_point{3,i};
    cell_T15_point_text{3,i} = cell_T15_point{3,i};
    cell_T20_point_text{3,i} = cell_T20_point{3,i};
end

save('T14_finalData.mat','cell_T14_point','cell_T14_point_text','cell_T14_point_train');
save('T15_finalData.mat','cell_T15_point','cell_T15_point_text','cell_T15_point_train');
save('T20_finalData.mat','cell_T20_point','cell_T20_point_text','cell_T20_point_train');
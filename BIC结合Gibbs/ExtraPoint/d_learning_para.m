clear all;clc;close all;
t_start = cputime;  %����ʱ��

% load T20_finalData.mat;
% X = [];
% len = size(cell_T20_point_train,2);
% for i = 1:len
%     X = [X;cell_T20_point_train{2,i}];
% end

% load T15_finalData.mat;
% X = [];
% len = size(cell_T15_point_train,2);
% for i = 1:len
%     X = [X;cell_T15_point_train{2,i}];
% end

load T14_finalData.mat;
X = [];
len = size(cell_T14_point_train,2);
for i = 1:len
    X = [X;cell_T14_point_train{2,i}];
end


numComlim=10;
AIC = zeros(1,numComlim);
BIC = zeros(1,numComlim);
GMModels = cell(1,numComlim);
options = statset('Display','final','MaxIter',1000,'TolFun',1e-5);
for k = 1:numComlim
    GMModels{k} = fitgmdist(X,k,'Options',options,'Replicates',1);
    AIC(k)= GMModels{k}.AIC;
    BIC(k)= GMModels{k}.BIC;
end

[minAIC,numComponentsAIC] = min(AIC);
numComponentsAIC

[minBIC,numComponentsBIC] = min(BIC);
numComponentsBIC

BestModelAIC = GMModels{numComponentsAIC};
BestModelBIC = GMModels{numComponentsBIC};
VoModel = GMModels{3};

figure(1)
plot(X(:,1),X(:,2),'ko')
title('Scatter Plot')
xlim([min(X(:,1)) max(X(:,1))]) % Make axes have the same scale
ylim([min(X(:,2)) max(X(:,2))])

figure(2);
set(gcf,'color','white');
plot(AIC,'-*k');
hold on;
plot(BIC,'-sk');
legend('AIC�Ż�׼��','BIC�Ż�׼��')
xlabel('�ֲ�Ԫ����');
ylabel('�Ż�׼��ֵ');

% save('T20model.mat','AIC','BIC','BestModelAIC','BestModelBIC','GMModels');
% save('T15model.mat','AIC','BIC','BestModelAIC','BestModelBIC','GMModels');
 save('T14model.mat','AIC','BIC','BestModelAIC','BestModelBIC','GMModels');

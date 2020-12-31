clear all;clc;close all;
load ex3_X2.mat;
X = pt1_train';
numComlim=10;
AIC = zeros(1,numComlim);
BIC = zeros(1,numComlim);
GMModels = cell(1,numComlim);
options = statset('Display','final','MaxIter',1000,'TolFun',1e-5);
for k = 1:numComlim
    GMModels{k} = fitgmdist(X,k,'Options',options,'Replicates',10);
    AIC(k)= GMModels{k}.AIC;
    BIC(k)= GMModels{k}.BIC;
end

[minAIC,numComponentsAIC] = min(AIC);
numComponentsAIC

[minBIC,numComponentsBIC] = min(BIC);
numComponentsBIC

BestModelAIC = GMModels{numComponentsAIC};
BestModelBIC = GMModels{numComponentsBIC};

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
legend('AIC优化准则','BIC优化准则')
xlabel('分布元个数');
ylabel('优化准则值');

%save('ex3_X2_model.mat','AIC','BIC','BestModelAIC','BestModelBIC','GMModels');
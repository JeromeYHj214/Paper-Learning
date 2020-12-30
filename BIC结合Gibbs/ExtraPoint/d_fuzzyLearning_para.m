clear all;clc;close all;
t_start = cputime;  %计算时间

load T20_finalData.mat;
X = [];
len = size(cell_T20_point_train,2);
for i = 1:len
    X = [X;cell_T20_point_train{2,i}];
end

% load T15_finalData.mat;
% X = [];
% len = size(cell_T15_point_train,2);
% for i = 1:len
%     X = [X;cell_T15_point_train{2,i}];
% end

% load T14_finalData.mat;
% X = [];
% len = size(cell_T14_point_train,2);
% for i = 1:len
%     X = [X;cell_T14_point_train{2,i}];
% end

I = size(X,1);

numComlim=10;
FCM_AIC = zeros(1,numComlim);
FCM_BIC = zeros(1,numComlim);
FCM_GMModels = cell(1,numComlim);
options = statset('Display','final','MaxIter',1000,'TolFun',1e-5);

for k = 1:numComlim
    if k==1
        FCM_GMModels{k} = fitgmdist(X,k,'Options',options);
    else
        
        [center,U,obj_fcn] = fcm(X,k);
        %% 画图用 不需要
        %     maxU = max(U);
        %     index = cell(1,k);
        %     for j = 1:k
        %         index{j} = find(U(j,:) == maxU);
        %     end
        % a = ['.r';'.g';'.b';'.c';'.m';'.y';'.k';'.w'];
        % plot(X(index{1},1),X(index{1},2),a(1,:))
        % hold on
        % plot(X(index{2},1),X(index{2},2),a(2,:))
        % hold on
        % plot(X(index{3},1),X(index{3},2),a(3,:))
        % hold on
        % plot(X(index{4},1),X(index{4},2),a(4,:))
        % hold on
        % plot(X(index{5},1),X(index{5},2),a(5,:))
        % hold on
        %% 生成EM的初始参数
        Mu = zeros(k,2); %k为分布元个数，2为特征维度；
        PComponents = zeros(1,k);
        for j = 1:k      %j表示k个分布元中第j个
            Mu_fenzi = 0;
            Mu_fenmu = 0;
            for i = 1:I
                Mu_fenzi = Mu_fenzi + U(j,i)*X(i,:);
                Mu_fenmu = Mu_fenmu + U(j,i);
            end
            Mu(j,:) = Mu_fenzi/Mu_fenmu;
            PComponents(j) = Mu_fenmu/I;
            Sig_fenzi = 0;
            Sig_fenmu = Mu_fenmu;
            for i = 1:I
                Sig_fenzi = Sig_fenzi +  U(j,i)*(X(i,:)-U(j,i))'*(X(i,:)-U(j,i));
            end
            Sigma(:,:,j) = Sig_fenzi/Sig_fenmu;
        end
        %%
        S = struct('mu',Mu,'Sigma',Sigma,'ComponentProportion',PComponents);
        FCM_GMModels{k} = fitgmdist(X,k,'Options',options,'Start',S);
    end
    FCM_AIC(k)= FCM_GMModels{k}.AIC;
    FCM_BIC(k)= FCM_GMModels{k}.BIC;
end

[minAIC,numComponentsAIC] = min(FCM_AIC);
numComponentsAIC

[minBIC,numComponentsBIC] = min(FCM_BIC);
numComponentsBIC

BestFCM_ModelAIC = FCM_GMModels{numComponentsAIC};
BestFCM_ModelBIC = FCM_GMModels{numComponentsBIC};
VoFCM_Model = FCM_GMModels{3};

figure(1)
plot(X(:,1),X(:,2),'ko')
title('Scatter Plot')
xlim([min(X(:,1)) max(X(:,1))]) % Make axes have the same scale
ylim([min(X(:,2)) max(X(:,2))])

figure(2);
set(gcf,'color','white');
plot(FCM_AIC,'-*k');
hold on;
plot(FCM_BIC,'-sk');
legend('AIC优化准则','BIC优化准则')
xlabel('分布元个数');
ylabel('优化准则值');

save('T20FCM_model.mat','FCM_AIC','FCM_BIC','BestFCM_ModelAIC','BestFCM_ModelBIC','FCM_GMModels');
 %save('T15FCM_model.mat','FCM_AIC','FCM_BIC','BestFCM_ModelAIC','BestFCM_ModelBIC','FCM_GMModels');
% save('T14FCM_model.mat','FCM_AIC','FCM_BIC','BestFCM_ModelAIC','BestFCM_ModelBIC','FCM_GMModels');

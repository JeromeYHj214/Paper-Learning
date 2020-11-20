close all;clear all;clc;

load ex2_X1.mat ;
load ex2_X1_para.mat ;
X_test = cell(8,40);
for i = 1 : 40
    X_test{1,i} = X1{1,100+i};
    X_test{2,i} = X1{2,100+i};
    X_test{3,i} = 1;
end

X_pos = 0;
for i = 1:100
    X_pos = X_pos +  X1{1,i};
end
X_pos = X_pos / 100;

% 3分布元
X1_alpha = canshu{1,2};
X1_mu = canshu{2,2};
X1_sigma = canshu{3,2};

% 4分布元
X2_alpha = canshu{1,3};
X2_mu = canshu{2,3};
X2_sigma = canshu{3,3};

%5分布元
X3_alpha = canshu{1,4};
X3_mu = canshu{2,4};
X3_sigma = canshu{3,4};

%6分布元
X4_alpha = canshu{1,5};
X4_mu = canshu{2,5};
X4_sigma = canshu{3,5};

%2分布元
X5_alpha = canshu{1,1};
X5_mu = canshu{2,1};
X5_sigma = canshu{3,1};
%% 开始测试
len = size(X_test,2);
count2 = 0;
count3 = 0;
count4 = 0;
count5 = 0;
count6 = 0;
for i = 1:len
    ge = X_test{1,i};
    X_test{4,i} = ge*log(X_pos)-X_pos;
    X_test{5,i} = ge*log(X_pos)-X_pos;
    X_test{6,i} = ge*log(X_pos)-X_pos;
    X_test{7,i} = ge*log(X_pos)-X_pos;
    for j = 1:ge
        
        X_test{4,i} = X_test{4,i} + log( X5_alpha(1)/(2*pi*det(X5_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X5_mu(1:2,1))'*inv(X5_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X5_mu(1:2,1))) +...
            X5_alpha(2)/(2*pi*det(X5_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X5_mu(1:2,2))'*inv(X5_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X5_mu(1:2,2))));
        
        X_test{5,i} = X_test{5,i} + log( X1_alpha(1)/(2*pi*det(X1_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,1))'*inv(X1_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X1_mu(1:2,1))) +...
            X1_alpha(2)/(2*pi*det(X1_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,2))'*inv(X1_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X1_mu(1:2,2))) + ...
            X1_alpha(3)/(2*pi*det(X1_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,3))'*inv(X1_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X1_mu(1:2,3))) );
        
        X_test{6,i} = X_test{6,i} + log( X2_alpha(1)/(2*pi*det(X2_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))'*inv(X2_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))) +...
            X2_alpha(2)/(2*pi*det(X2_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))'*inv(X2_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))) + ...
            X2_alpha(3)/(2*pi*det(X2_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))'*inv(X2_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))) + ...
            X2_alpha(4)/(2*pi*det(X2_sigma(:,:,4))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,4))'*inv(X2_sigma(:,:,4))*(X_test{2,i}(1:2,j)-X2_mu(1:2,4))));
        
        X_test{7,i} = X_test{7,i} + log( X3_alpha(1)/(2*pi*det(X3_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,1))'*inv(X3_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X3_mu(1:2,1))) +...
            X3_alpha(2)/(2*pi*det(X3_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,2))'*inv(X3_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X3_mu(1:2,2))) + ...
            X3_alpha(3)/(2*pi*det(X3_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,3))'*inv(X3_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X3_mu(1:2,3))) + ...
            X3_alpha(4)/(2*pi*det(X3_sigma(:,:,4))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,4))'*inv(X3_sigma(:,:,4))*(X_test{2,i}(1:2,j)-X3_mu(1:2,4))) + ...
            X3_alpha(5)/(2*pi*det(X3_sigma(:,:,5))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,5))'*inv(X3_sigma(:,:,5))*(X_test{2,i}(1:2,j)-X3_mu(1:2,5))) );
        
        X_test{8,i} = X_test{7,i} + log( X4_alpha(1)/(2*pi*det(X4_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X4_mu(1:2,1))'*inv(X4_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X4_mu(1:2,1))) +...
            X4_alpha(2)/(2*pi*det(X4_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X4_mu(1:2,2))'*inv(X4_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X4_mu(1:2,2))) + ...
            X4_alpha(3)/(2*pi*det(X4_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X4_mu(1:2,3))'*inv(X4_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X4_mu(1:2,3))) + ...
            X4_alpha(4)/(2*pi*det(X4_sigma(:,:,4))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X4_mu(1:2,4))'*inv(X4_sigma(:,:,4))*(X_test{2,i}(1:2,j)-X4_mu(1:2,4))) + ...
            X4_alpha(5)/(2*pi*det(X4_sigma(:,:,5))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X4_mu(1:2,5))'*inv(X4_sigma(:,:,5))*(X_test{2,i}(1:2,j)-X4_mu(1:2,5))) + ...
            X4_alpha(6)/(2*pi*det(X4_sigma(:,:,6))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X4_mu(1:2,6))'*inv(X4_sigma(:,:,6))*(X_test{2,i}(1:2,j)-X4_mu(1:2,6))));
    end
    
    if (X_test{5,i} < X_test{7,i} && X_test{6,i} < X_test{7,i} && X_test{8,i} < X_test{7,i} && X_test{4,i} < X_test{7,i})
        count5 = count5 + 1;
    elseif(X_test{6,i} < X_test{5,i} && X_test{7,i} < X_test{5,i} && X_test{8,i} < X_test{5,i} && X_test{4,i} < X_test{5,i})
        count3 = count3 + 1;
    elseif(X_test{5,i} < X_test{6,i} && X_test{7,i} < X_test{6,i} && X_test{8,i} < X_test{6,i} && X_test{4,i} < X_test{6,i})
        count4 = count4 + 1;
    elseif(X_test{5,i} < X_test{4,i} && X_test{6,i} < X_test{4,i} && X_test{7,i} < X_test{4,i} && X_test{8,i} < X_test{4,i})
        count2 = count2 + 1;
    else
        count6 = count6 + 1;
    end
end

figure;
set(gcf,'color','white');
data = [count2 count3 count4 count5 count6];
b=bar(data);
set(gca,'XTickLabel',{'二分布元','三分布元','四分布元','五分布元','六分布元'})
set(gca,'YLim',[0 40])
ylabel('样本个数（个）');
title('测试集样本对模型选择的投票结果');
%saveas(gcf, 'ex1_ClaPer', 'png');
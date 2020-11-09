close all;clear all;clc;

load ex2_X1.mat ;
load ex2_X1_para.mat ;
X_test = cell(7,40);
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

%% 开始测试
len = size(X_test,2);
count = 1;
for i = 1:len
    ge = X_test{1,i};
    X_test{5,i} = ge*log(X_pos)-X_pos;
    X_test{6,i} = ge*log(X_pos)-X_pos;
    %X_test{7,i} = ge*log(X_pos)-X_pos;
    for j = 1:ge
        X_test{5,i} = X_test{5,i} + log( X1_alpha(1)/(2*pi*det(X1_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,1))'*inv(X1_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X1_mu(1:2,1))) +...
            X1_alpha(2)/(2*pi*det(X1_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,2))'*inv(X1_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X1_mu(1:2,2))) + ...
            X1_alpha(3)/(2*pi*det(X1_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,3))'*inv(X1_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X1_mu(1:2,3))) );
        
        X_test{6,i} = X_test{6,i} + log( X2_alpha(1)/(2*pi*det(X2_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))'*inv(X2_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))) +...
            X2_alpha(2)/(2*pi*det(X2_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))'*inv(X2_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))) + ...
            X2_alpha(3)/(2*pi*det(X2_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))'*inv(X2_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))) + ...
            X2_alpha(4)/(2*pi*det(X2_sigma(:,:,4))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,4))'*inv(X2_sigma(:,:,4))*(X_test{2,i}(1:2,j)-X2_mu(1:2,4))));
        
%         X_test{7,i} = X_test{7,i} + log( X3_alpha(1)/(2*pi*det(X3_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,1))'*inv(X3_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X3_mu(1:2,1))) +...
%             X3_alpha(2)/(2*pi*det(X3_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,2))'*inv(X3_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X3_mu(1:2,2))) + ...
%             X3_alpha(3)/(2*pi*det(X3_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,3))'*inv(X3_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X3_mu(1:2,3))) );
    end
    
    if X_test{5,i} < X_test{6,i}
        count = count + 1;
    end
end
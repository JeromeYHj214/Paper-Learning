clear all;close all;clc;
%% 获取X1的测试集与泊松强度
load ex3_X1.mat
load ex3_X1_para
X1_test = cell(7,40);
for i = 1:40
    X1_test{1,i} = X1{1,100+i};
    X1_test{2,i} = X1{2,100+i};
    X1_test{3,i} = 1;
end
X1_pos = 0;
for i = 1:100
    X1_pos = X1_pos +  X1{1,i};
end
X1_pos = X1_pos / 100;
X1_alpha = canshu{1,2};
X1_mu = canshu{2,2};
X1_sigma = canshu{3,2};

%% 获取X2的测试集与泊松强度
load ex3_X2.mat
load ex3_X2_para
X2_test = cell(7,40);
for i = 1:40
    X2_test{1,i} = X1{1,100+i};
    X2_test{2,i} = X1{2,100+i};
    X2_test{3,i} = 2;
end
X2_pos = 0;
for i = 1:100
    X2_pos = X2_pos +  X1{1,i};
end
X2_pos = X2_pos / 100;
% X2_alpha = canshu{1,2};
% X2_mu = canshu{2,2};
% X2_sigma = canshu{3,2};
X2_alpha = canshu{1,1};
X2_mu = canshu{2,1};
X2_sigma = canshu{3,1};

%% 获取X3的测试集与泊松强度
load ex3_X3.mat
load ex3_X2_para
X3_test = cell(7,40);
for i = 1:40
    X3_test{1,i} = X1{1,100+i};
    X3_test{2,i} = X1{2,100+i};
    X3_test{3,i} = 3;
end
X3_pos = 0;
for i = 1:100
    X3_pos = X3_pos +  X1{1,i};
end
X3_pos = X3_pos / 100;
X3_alpha = canshu{1,2};
X3_mu = canshu{2,2};
X3_sigma = canshu{3,2};

%% 绘制测试集的基数分布
X1_test_cad = [];
X2_test_cad = [];
X3_test_cad = [];
for i = 1:40
    X1_test_cad = [X1_test_cad  X1_test{1,i}];
    X2_test_cad = [X2_test_cad  X2_test{1,i}];
    X3_test_cad = [X3_test_cad  X3_test{1,i}];
end
max_val = max([X1_test_cad X2_test_cad X3_test_cad]);
X1_test_cad_ratio = zeros(1,max_val);
X2_test_cad_ratio = zeros(1,max_val);
X3_test_cad_ratio = zeros(1,max_val);
for i = 1:max_val
    a = length(find(X1_test_cad == i));
    b = length(find(X2_test_cad == i));
    c = length(find(X3_test_cad == i));
    X1_test_cad_ratio(i) = a / 40;
    X2_test_cad_ratio(i) = b / 40;
    X3_test_cad_ratio(i) = c / 40;
end
bar_set=zeros(max_val,3);
for i = 1:max_val
    bar_set(i,1)=X1_test_cad_ratio(i);
    bar_set(i,2)=X2_test_cad_ratio(i);
    bar_set(i,3)=X3_test_cad_ratio(i);
end
figure;
set(gcf,'color','white');
b = bar(bar_set,4);
color = ['r','b','g'];
set(b(1),'FaceColor',color(1));
set(b(2),'FaceColor',color(2));
set(b(3),'FaceColor',color(3));
legend('Class 1','Class 2','Class 3');
ylabel('Frequency');
xlabel('Cardinality n');
title('Cardinality histogram');
%saveas(gcf, 'ex3_card_Dis', 'png');
%% 绘制测试集的特征分布
figure;
set(gcf,'color','white');
for i = 1:40
    plot(X1_test{2,i}(1,:),X1_test{2,i}(2,:),'.r');
    hold on
    plot(X2_test{2,i}(1,:),X2_test{2,i}(2,:),'.b');
    hold on
    plot(X3_test{2,i}(1,:),X3_test{2,i}(2,:),'.g');
    hold on
end
xlabel('X');
ylabel('Y');
legend('Class 1','Class 2','Class 3');
title('Feature Distribution');
%saveas(gcf, 'ex3_featureDis', 'png');

%% 开始测试
X_test = [X1_test X2_test X3_test];
len = size(X_test,2);

%% 点模式+二分布元 
for i = 1:len
    ge = X_test{1,i};
    X_test{5,i} = ge*log(X1_pos)-X1_pos;
    X_test{6,i} = ge*log(X2_pos)-X2_pos;
    X_test{7,i} = ge*log(X3_pos)-X3_pos;
    for j = 1:ge
        X_test{5,i} = X_test{5,i} + log( X1_alpha(1)/(2*pi*det(X1_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,1))'*inv(X1_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X1_mu(1:2,1))) +...
            X1_alpha(2)/(2*pi*det(X1_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,2))'*inv(X1_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X1_mu(1:2,2))) + ...
            X1_alpha(3)/(2*pi*det(X1_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,3))'*inv(X1_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X1_mu(1:2,3))) );
        
        %三分布元
        %                 X_test{6,i} = X_test{6,i} + log( X2_alpha(1)/(2*pi*det(X2_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))'*inv(X2_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))) +...
        %                     X2_alpha(2)/(2*pi*det(X2_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))'*inv(X2_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))) + ...
        %                     X2_alpha(3)/(2*pi*det(X2_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))'*inv(X2_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))) );
        
        %二分布元
        X_test{6,i} = X_test{6,i} + log( X2_alpha(1)/(2*pi*det(X2_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))'*inv(X2_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))) +...
            X2_alpha(2)/(2*pi*det(X2_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))'*inv(X2_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))));
        
        %四分布元
        %         X_test{6,i} = X_test{6,i} + log( X2_alpha(1)/(2*pi*det(X2_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))'*inv(X2_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))) +...
        %             X2_alpha(2)/(2*pi*det(X2_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))'*inv(X2_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))) + ...
        %             X2_alpha(3)/(2*pi*det(X2_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))'*inv(X2_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))) +...
        %             X2_alpha(4)/(2*pi*det(X2_sigma(:,:,4))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,4))'*inv(X2_sigma(:,:,4))*(X_test{2,i}(1:2,j)-X2_mu(1:2,4))) );
        
        X_test{7,i} = X_test{7,i} + log( X3_alpha(1)/(2*pi*det(X3_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,1))'*inv(X3_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X3_mu(1:2,1))) +...
            X3_alpha(2)/(2*pi*det(X3_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,2))'*inv(X3_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X3_mu(1:2,2))) + ...
            X3_alpha(3)/(2*pi*det(X3_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,3))'*inv(X3_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X3_mu(1:2,3))) );
    end
    if X_test{5,i} > X_test{6,i} && X_test{5,i} > X_test{7,i}
        X_test{4,i} = 1;
    elseif X_test{6,i} > X_test{5,i} && X_test{6,i} > X_test{7,i}
        X_test{4,i} = 2;
    else
        X_test{4,i} = 3;
    end
end
count_nc = 0;
for i = 1:len
    if X_test{3,i}==X_test{4,i}
        count_nc = count_nc + 1;
    end
end
rate_nc = count_nc/len;

%% 点模式概率 + 3分布元
X2_alpha = canshu{1,2};
X2_mu = canshu{2,2};
X2_sigma = canshu{3,2};
for i = 1:len
    ge = X_test{1,i};
    X_test{5,i} = ge*log(X1_pos)-X1_pos;
    X_test{6,i} = ge*log(X2_pos)-X2_pos;
    X_test{7,i} = ge*log(X3_pos)-X3_pos;
    for j = 1:ge
        X_test{5,i} = X_test{5,i} + log( X1_alpha(1)/(2*pi*det(X1_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,1))'*inv(X1_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X1_mu(1:2,1))) +...
            X1_alpha(2)/(2*pi*det(X1_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,2))'*inv(X1_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X1_mu(1:2,2))) + ...
            X1_alpha(3)/(2*pi*det(X1_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X1_mu(1:2,3))'*inv(X1_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X1_mu(1:2,3))) );
        %三分布元
                        X_test{6,i} = X_test{6,i} + log( X2_alpha(1)/(2*pi*det(X2_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))'*inv(X2_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))) +...
                            X2_alpha(2)/(2*pi*det(X2_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))'*inv(X2_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))) + ...
                            X2_alpha(3)/(2*pi*det(X2_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))'*inv(X2_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))) );
        %二分布元
%         X_test{6,i} = X_test{6,i} + log( X2_alpha(1)/(2*pi*det(X2_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))'*inv(X2_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))) +...
%             X2_alpha(2)/(2*pi*det(X2_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))'*inv(X2_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))));
        %四分布元
        %         X_test{6,i} = X_test{6,i} + log( X2_alpha(1)/(2*pi*det(X2_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))'*inv(X2_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X2_mu(1:2,1))) +...
        %             X2_alpha(2)/(2*pi*det(X2_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))'*inv(X2_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X2_mu(1:2,2))) + ...
        %             X2_alpha(3)/(2*pi*det(X2_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))'*inv(X2_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X2_mu(1:2,3))) +...
        %             X2_alpha(4)/(2*pi*det(X2_sigma(:,:,4))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X2_mu(1:2,4))'*inv(X2_sigma(:,:,4))*(X_test{2,i}(1:2,j)-X2_mu(1:2,4))) );
        
        X_test{7,i} = X_test{7,i} + log( X3_alpha(1)/(2*pi*det(X3_sigma(:,:,1))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,1))'*inv(X3_sigma(:,:,1))*(X_test{2,i}(1:2,j)-X3_mu(1:2,1))) +...
            X3_alpha(2)/(2*pi*det(X3_sigma(:,:,2))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,2))'*inv(X3_sigma(:,:,2))*(X_test{2,i}(1:2,j)-X3_mu(1:2,2))) + ...
            X3_alpha(3)/(2*pi*det(X3_sigma(:,:,3))^0.5)*exp(-0.5*(X_test{2,i}(1:2,j)-X3_mu(1:2,3))'*inv(X3_sigma(:,:,3))*(X_test{2,i}(1:2,j)-X3_mu(1:2,3))) );
    end
    if X_test{5,i} > X_test{6,i} && X_test{5,i} > X_test{7,i}
        X_test{4,i} = 1;
    elseif X_test{6,i} > X_test{5,i} && X_test{6,i} > X_test{7,i}
        X_test{4,i} = 2;
    else
        X_test{4,i} = 3;
    end
end
count_wc = 0;
for i = 1:len
    if X_test{3,i}==X_test{4,i}
        count_wc = count_wc + 1;
    end
end
rate_wc = count_wc/len;
%% 绘制结果
figure;
set(gcf,'color','white');
data = [rate_nc rate_wc];
b=bar(data);
set(gca,'XTickLabel',{'Model One','Model Two'})
set(gca,'YLim',[0 1.0])
ylabel('Accuracy');
title('Classification Performance');
saveas(gcf, 'ex4_ClaPer', 'png');
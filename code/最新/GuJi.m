clear;clc;
load data_of_3.mat
% figure(1);
% for i = 1:100
%     subplot(10,10,i)
%     plot(X1{i}(:,1),X1{i}(:,2),'+','color','b');
%     hold on;
%     plot(X2{i}(:,1),X2{i}(:,2),'x','color','r');
%     hold on;
% end
% figure(2);
% for i = 1:100
%     plot(X1{i}(:,1),X1{i}(:,2),'+','color','b');
%     plot(X2{i}(:,1),X2{i}(:,2),'x','color','r');
%     hold on;
% end

%%
[a , num] = size(X1);
he_Z = 0;

for i = 1:num
    he_Z = X1_ori{i}(:,1:2) + he_Z;
end

mean_Z = he_Z / num;

var_z1 = zeros(2);
for i = 1:num
    var_z1 = var_z1 + 1 / num * ((X1_ori{i}(1,1:2) - mean_Z(1,1:2))' * (X1_ori{i}(1,1:2) - mean_Z(1,1:2)));
end

var_z2 = zeros(2);
for i = 1:num
    var_z2 = var_z2 + 1 / num * ((X1_ori{i}(2,1:2) - mean_Z(2,1:2))' * (X1_ori{i}(2,1:2) - mean_Z(2,1:2)));
end

var_z3 = zeros(2);
for i = 1:num
    var_z3 = var_z3 + 1 / num * ((X1_ori{i}(3,1:2) - mean_Z(3,1:2))' * (X1_ori{i}(3,1:2) - mean_Z(3,1:2)));
end

%%
he_X = 0;

for i = 1:num
    he_X = X2_ori{i}(:,1:2) + he_X;
end

mean_X = he_X / num;

var_x1 = zeros(2);
for i = 1:num
    var_x1 = var_x1 + 1 / num * ((X2_ori{i}(1,1:2) - mean_Z(1,1:2))' * (X2_ori{i}(1,1:2) - mean_Z(1,1:2)));
end

var_x2 = zeros(2);
for i = 1:num
    var_x2 = var_x2 + 1 / num * ((X2_ori{i}(2,1:2) - mean_Z(2,1:2))' * (X2_ori{i}(2,1:2) - mean_Z(2,1:2)));
end

var_x3 = zeros(2);
for i = 1:num
    var_x3 = var_x3 + 1 / num * ((X2_ori{i}(3,1:2) - mean_Z(3,1:2))' * (X2_ori{i}(3,1:2) - mean_Z(3,1:2)));
end

%%
var_n1 = var_z1 - var_x1;
var_n2 = var_z2 - var_x2;
var_n3 = var_z3 - var_x3;
 %% ²âÊÔ
var_n1 = 0.01 * eye(2);
var_n2 = 0.01 * eye(2);
var_n3 = 0.01 * eye(2);
var_x1 = 0.01 * eye(2);
var_x2 = 0.02 * eye(2);
var_x3 = 0.03 * eye(2);
mean_X = [4 16 ; 8 12;12 8];
%%
var_x1x2 = (var_x1 * var_x2)^0.5;
var_x2x3 = (var_x2 * var_x3)^0.5;
%%
guji = cell(1,num);
aa1 = var_n1^(-1);
bb1 = var_x1^(-1);
cc1 = (aa1 + bb1)^(-1);

aa2 = var_n2^(-1);
bb2 = var_x2^(-1);
cc2 = (aa2 + bb2)^(-1);

aa3 = var_n3^(-1);
bb3 = var_x3^(-1);
cc3 = (aa3 + bb3)^(-1);

for i = 1:num
   zz1 = cc1*(aa1* X1_ori{i}(1,1:2)' + bb1*mean_X(1,:)');
   zz2 = cc2*(aa2* X1_ori{i}(2,1:2)' + bb2*mean_X(2,:)');
   zz3 = cc3*(aa3* X1_ori{i}(3,1:2)' + bb3*mean_X(3,:)');
   guji{i} = zz1';
   guji{i} = [guji{i}; zz2'];
   guji{i} = [guji{i}; zz3'];
end

err = zeros(3,num);
errd = zeros(3,num);
erru = zeros(3,num);
errud = zeros(3,num);
for i = 1:num
    err(1,i) = (guji{i}(1,1)-X2_ori{i}(1,1))^2 + (guji{i}(1,2)-X2_ori{i}(1,2))^2;
    err(2,i) = (guji{i}(2,1)-X2_ori{i}(2,1))^2 + (guji{i}(2,2)-X2_ori{i}(2,2))^2;
    err(3,i) = (guji{i}(3,1)-X2_ori{i}(3,1))^2 + (guji{i}(3,2)-X2_ori{i}(3,2))^2;
    
    errd(1,i) = (X2_ori{i}(1,1)-X1_ori{i}(1,1))^2 + (X2_ori{i}(1,2)-X1_ori{i}(1,2))^2;
    errd(2,i) = (X2_ori{i}(2,1)-X1_ori{i}(2,1))^2 + (X2_ori{i}(2,2)-X1_ori{i}(2,2))^2;
    errd(3,i) = (X2_ori{i}(3,1)-X1_ori{i}(3,1))^2 + (X2_ori{i}(3,2)-X1_ori{i}(3,2))^2; 
end
cha = errd -err;

index = cha > 0
count = 0;

for i = 1:3
    for j = 1:num
        if index(i,j) == 1
            count = count + 1;
        end
    end
end

% zongcha = zeros(1,num);
% for i = 1:num
%     zongcha(i) = cha(1,i) + cha(2,i) + cha(3,i);
% end
% 
% index1 = zongcha > -0.03
% count1 = 0;
% for i = 1:num
%     if index1(i)
%         count1 = count1 + 1;
%     end
% end
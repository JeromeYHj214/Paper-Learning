%----------------------
%      cell操作
%----------------------
close; clc; clear;
A = cell(2,10);
for i=1:10
 A{1,i}=rand(2,3);
end

%------------------
%     图像操作
%------------------
% close; clc; clear;
% x = imread('lena512.bmp');
% y = imread('7.png');
% subplot(2,2,1);
% imshow(x)
% subplot(2,2,2);
% imshow(y)
% y = rgb2gray(y);        %rgb转灰度
% subplot(2,2,3);
% imshow(y)
% ybw = im2bw(x,0.5);    %转化为二值图像
% subplot(2,2,4);
% imshow(ybw)
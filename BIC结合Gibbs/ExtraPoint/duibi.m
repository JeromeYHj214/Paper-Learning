clear all;close all;clc;
run('E:\VLFeat\vlfeat-0.9.21\toolbox\vl_setup.m')
vl_version verbose
% 彩色特征点更多
subplot(1,2,1);
set(gcf,'color','white');
I1 = imread('S1014L40.jpg') ;
imshow(I1);
I1 = single(I1);
[f1, d1] = vl_sift(I1,'Levels',3,'PeakThresh', 10);
 h1 = vl_plotframe(f1);
set(h1,'color','y','linewidth',2);
xlabel('(a)黑白','Fontsize',15);

subplot(1,2,2);
I2 = imread('39.jpg') ;
imshow(I2);
I2 = single(rgb2gray(I2));
[f2, d2] = vl_sift(I2,'Levels',3,'PeakThresh', 9);
 h2 = vl_plotframe(f2);
set(h2,'color','y','linewidth',2);
xlabel('(b)彩色','Fontsize',15);
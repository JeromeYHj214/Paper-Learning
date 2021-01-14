clear all;close all;clc;
run('E:\VLFeat\vlfeat-0.9.21\toolbox\vl_setup.m')
vl_version verbose

subplot(1,3,1);
set(gcf,'color','white');
I = imread('E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T14_brick1\\S1014L02.jpg') ;
imshow(I);
I = single(I);
[f,d] = vl_sift(I) ;
[f, d] = vl_sift(I,'Levels',3,'PeakThresh', 10);
 h = vl_plotframe(f);
set(h,'color','y','linewidth',2);
xlabel('T14 brick1','Fontsize',15);
%title('£¨a£©','Fontsize',15,'position',[-15,20]);

subplot(1,3,2);
I = imread('E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T15_brick2\\S1015L12.jpg') ;
imshow(I);
I = single(I);
[f,d] = vl_sift(I) ;
[f, d] = vl_sift(I,'Levels',3,'PeakThresh', 10);
 h = vl_plotframe(f);
set(h,'color','y','linewidth',2);
xlabel('T15 brick2','Fontsize',15);
%title('£¨b£©','Fontsize',15,'position',[-15,20]);

subplot(1,3,3);
I = imread('E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T20_upholstery\\S1020L03.jpg') ;
imshow(I);
I = single(I);
[f,d] = vl_sift(I) ;
[f, d] = vl_sift(I,'Levels',3,'PeakThresh', 8);
 h = vl_plotframe(f);
set(h,'color','y','linewidth',2);
xlabel('T20 upholstery','Fontsize',15);
%title('£¨c£©','Fontsize',15,'position',[-15,20]);
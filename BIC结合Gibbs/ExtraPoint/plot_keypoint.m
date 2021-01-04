clear all;close all;clc;

subplot(1,3,1);
set(gcf,'color','white');
I = imread('T14.jpg') ;
imshow(I);
I = single(I);
[f,d] = vl_sift(I) ;
[f, d] = vl_sift(I,'Levels',3,'PeakThresh', 10);
 h = vl_plotframe(f);
set(h,'color','y','linewidth',2);
xlabel('(a)T14 brick1','Fontsize',15);

subplot(1,3,2);
I = imread('T15.jpg') ;
imshow(I);
I = single(I);
[f,d] = vl_sift(I) ;
[f, d] = vl_sift(I,'Levels',3,'PeakThresh', 9);
 h = vl_plotframe(f);
set(h,'color','y','linewidth',2);
xlabel('(b)T15 brick2','Fontsize',15);

subplot(1,3,3);
I = imread('T20.jpg') ;
imshow(I);
I = single(I);
[f,d] = vl_sift(I) ;
[f, d] = vl_sift(I,'Levels',2,'PeakThresh', 10);
 h = vl_plotframe(f);
set(h,'color','y','linewidth',2);
xlabel('(c)T20 upholstery','Fontsize',15);
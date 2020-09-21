%实现PRML P387 例子：使用mrf降噪
%输入一个二值图像并加入噪声
clc
close all;
clear all;
I=imread('lena512.bmp');
I1=im2bw(I);
subplot(2,2,1)
imshow(I1);
title('原图像');
J = imnoise(I,'salt & pepper', 0.2);
J1=im2bw(J);
subplot(2,2,2)
imshow(J1);
title('噪声图')

Y=ones(size(J1));
Y(J1==0)=-1;
[m,n]=size(Y);
X=Y;h=0;beta=3.5;eta=.1;
while 1
    tot=0
    for i=2:1:m-1
        for j=2:1:n-1
            temp=X(i,j);
            X(i,j)=-1;%根据定义计算势函数
            E1=h*X(i,j)-beta*X(i,j)*(X(i-1,j)+X(i+1,j)+X(i,j-1)+X(i,j+1))-eta*X(i,j)*Y(i,j);
            X(i,j)=1;
            E2=h*X(i,j)-beta*X(i,j)*(X(i-1,j)+X(i+1,j)+X(i,j-1)+X(i,j+1))-eta*X(i,j)*Y(i,j);
            if E1<E2
                X(i,j)=-1;
            else
                X(i,j)=1;
            end
            if temp~=X(i,j)
                tot=tot+1;
            end
        end
    end
    if tot<1
        break;
    end
end

J2=X;
J2(X==-1)=0;
subplot(2,2,3)
imshow(J2);
title('mrf降噪结果')
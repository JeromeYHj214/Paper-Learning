%  fit the distribution of a Gaussdata
%% 用不上 
function Gibbs2()
clear all;close all;clc;
t_start = cputime;
%%
%修改前
%load mydata.mat;      %data file
%修改后;不适用
load X2.mat ;
Pt = pt2_train;
%%
addpath('F:\mypaper\common file');

% load bo3.mat
% Pt1 = Bo3;
% [I,J] = size(Pt1);
% Pt = [Pt1(2,:);I-Pt1(1,:)]+ randn(I,J);

plot(Pt(1,:), Pt(2,:), '.k');

Num = size(Pt,2);     %Pt: observation point: two-dimention
x_dim = size(Pt,1);
x_min = min(Pt(1,:));
x_max = max(Pt(1,:));
y_min = min(Pt(2,:));
y_max = max(Pt(2,:));

%the initial value for means and covariance matrix of four Gauss
%the means are unifrom in the data space. The covariacnes are all unit
%matrix. The weights of individual distributions are equal.

%100: The max num of the iteration
K = 100;          %iterative times
I = 2:5;

pos = get(gcf, 'Position');
width = pos(3);
height = pos(4);
mov = zeros(height, width, 1, length(K), 'uint8');

logBICv = zeros(size(I,2),K);
for i=1:size(I,2)
    cnum = I(i);
    for m=1:cnum
        miu(:,m) = [unifrnd(x_min,x_max,1);unifrnd(y_min,y_max,1)];
        cov_Pt(:,:,m) = [diag(ones(1,x_dim))];
        wi(m) = 1/cnum;
    end
    
    for k=1:K
        sum_wi = zeros(1,size(Pt,2));
        for m=1:cnum
            Error_x(:,:,m) = Pt - repmat(miu(:,m),1,size(Pt,2));
            ui(m,:) = norm_pdf(Error_x(:,:,m),cov_Pt(:,:,m));
            sum_wi = sum_wi + wi(m)*ui(m,:);
        end
        
        logBICv(i,k) = 2*sum(-log(sum_wi)) + cnum*7*log(Num);
        for m=1:cnum                              % the number of distributions
            eij(m,:) = wi(m)*ui(m,:)./sum_wi;
            n(m) = sum(eij(m,:))+1;
        end
        wi = n/sum(n);                           %weight
        
        for m=1:cnum
            x_bar(:,m) = sum((repmat(eij(m,:),2,1).*Pt)')'/n(m);
            detPt(:,:,m) = Pt - repmat(x_bar(:,m),1,size(Pt,2));
            sumPt(:,:,m) = (repmat(eij(m,:),[x_dim,1]).*detPt(:,:,m))*detPt(:,:,m)'+ eye(x_dim); %parameter
            
            P(:,:,m) = wishrnd(inv(sumPt(:,:,m)),x_dim+n(m));                   %sampling covariances
            cov_Pt(:,:,m) = inv(P(:,:,m));
            miu(:,m) = x_bar(:,m)+ chol(cov_Pt(:,:,m))*randn(x_dim,1)/(1+n(m));  %sampling means.
        end
        
        plot(Pt(1,:),Pt(2,:),'.k');
        set(gcf,'color','white');
        
        hold on;
        for m=1:cnum
            [ex1,ey11,ex2,ey12] = Get_Ellipse(miu(:,m),cov_Pt(:,:,m));
            plot(ex1,ey11,'b',ex2,ey12,'b');
        end
        title(['Times:',num2str(k)]);
        
        
        f = getframe(gcf);
        % Create a colormap for the first frame. For the rest of the frames,
        % use the same colormap
        
        if k == 1 && i==1
            [mov(:,:,1,(i-1)*K+k), map] = rgb2ind(f.cdata, 256, 'nodither');
        else
            mov(:,:,1,(i-1)*K+k) = rgb2ind(f.cdata, map, 'nodither');
        end
        
        
        hold off;
        pause(0.02);
        %disp(['n=',num2str(k),' wi= ', num2str(wi)]);
    end
    AICv(i) = 2*sum(-log(sum_wi)) + 2*cnum*7;    %AIC
    BICv(i) = 2*sum(-log(sum_wi)) + cnum*7*log(Num);    %BIC
    
end
imwrite(mov, map, 'four_component.gif', 'DelayTime', 0, 'LoopCount', inf);

%save FMM_parameter.mat wi miu cov_Pt AICv BICv I logBICv -append;
save FMM_parameter.mat wi miu cov_Pt AICv BICv I logBICv ;
%load FMM_parameter.mat;
figure;
plot(I,AICv,'-*k',I,BICv,'-sk');
legend('AIC优化准则','BIC优化准则');
xlabel('分布元个数');
ylabel('信息优化准则');


pos = get(gcf, 'Position');
width = pos(3);
height = pos(4);
mov1 = zeros(height, width, 1, length(K), 'uint8');

figure;
box on;
axis([0 100 8500 11000]);
set(gcf,'color','white');

hold on;
for i=1:size(I,2)
    for k=1:K
        plot(logBICv(i,2:k),'.-k');
        text(K-50,logBICv(i,K)-50,['num=',num2str(I(i))]);
        pause(0.01);
        f = getframe(gcf);
        
        if k == 1 && i==1
            [mov1(:,:,1,(i-1)*K+k), map] = rgb2ind(f.cdata, 256, 'nodither');
        else
            mov1(:,:,1,(i-1)*K+k) = rgb2ind(f.cdata, map, 'nodither');
        end
    end
end
xlabel('迭代步数');
ylabel('BIC信息优化准则');
imwrite(mov1, map, 'BIC_processing.gif', 'DelayTime', 0, 'LoopCount', inf);

t_end = cputime;
t_total = t_end - t_start;
end


%
% figure;
% plot(I,BICv);

% for i=1:size(I,2)
%   plot(AICv(i,2:K),'-.k');
%   text(K-20,AICv(i,K)-5,['num=',num2str(I(i))]);
% end

% figure;
% hold on;
% for i=1:size(I,2)
%   plot(BICv(i,2:K),'-.k');
%   text(K-20,BICv(i,K)-5,['num=',num2str(I(i))]);
% end

%ellipse points
% function [ex1,ey1,ex2,ey2] = Get_Ellipse(miu,segma)
% [A,B] = eig(segma);
% a = 2*sqrt(B(1,1));
% b = 2*sqrt(B(2,2));
% xmin = -a;
% xmax = a;
% x = xmin:0.01:xmax;
% y1 = b*sqrt((1-x.*x/(a*a)));
% y2 = -b*sqrt((1-x.*x/(a*a)));
% pxy1 = A*[x;y1];
% pxy2 = A*[x;y2];
% xy1 = [pxy1(1,:)+miu(1);pxy1(2,:)+miu(2)];
% xy2 = [pxy2(1,:)+miu(1);pxy2(2,:)+miu(2)];
% ex1 = xy1(1,:);
% ey1= xy1(2,:);
% ex2 = xy2(1,:);
% ey2= xy2(2,:);

function Gibbs2()
clear all;
t_start = cputime;      % 计算时间
load dianzi2.mat;        % data file
load matlab3.mat;        % data file
% Num = size(Pt,2);       % Pt: 观测数据 ,  Num=3000, Pt为2行3000列的矩阵
x_dim = size(Pt,1);     % x_dim为行数2
x_min = min(Pt(1,:));   % x_min为第一行中最小的数
x_max = max(Pt(1,:));   % x_max为第一行中最大的数
y_min = min(Pt(2,:));   % y_min为第二行中最小的数
y_max = max(Pt(2,:));   % y_max为第二行中最大的数
I = 2:3;
K = 100;                %iterative times  迭代次数100           
% logBICv = zeros(3,K);   %3*100的零矩阵
plot(true_hh.mixture_comp{1}, 'LineWidth', 1.5); 
hold on
plot(true_hh.mixture_comp{2}, 'LineWidth', 1.5); 
hold on 
plot(true_hh.mixture_comp{3}, 'LineWidth', 1.5); 
for i=1:2     
     cnum =I(i);
     for m=1:cnum
         miu(:,m) = [unifrnd(x_min,x_max,1);unifrnd(y_min,y_max,1)];   
         cov_Pt(:,:,m) = 10*[diag(ones(1,x_dim))];                         %限定范围初始化均值,方差,组分均值 组分个数即混合模型的参数
         wi(m) = 1/cnum;                                               
     end                                                               
    
     for k=1:100
           sum_wi = zeros(1,size(Pt,2));                                   %1*3000
           for m=1:cnum
               Error_x(:,:,m) = Pt - repmat(miu(:,m),1,size(Pt,2));        
               ui(m,:) = norm_pdf(Error_x(:,:,m),cov_Pt(:,:,m));           %正态概率密度函数
               sum_wi = sum_wi + wi(m)*ui(m,:);                            %sum_wi为似然函数
           end
        
%            logBICv(i,k) = 2*sum(-log(sum_wi)) + cnum*7*log(Num);  
           for m=1:cnum                                                    %各组分的数据个数分布
               eij(m,:) = wi(m)*ui(m,:)./sum_wi;                           %缺失变量
               n(m) = sum(eij(m,:))+1;
           end
           wi = n/sum(n);                                                  %weight组分占比

           for m=1:cnum
               x_bar(:,m) = sum((repmat(eij(m,:),2,1).*Pt)')'/n(m);        %￥ 
               detPt(:,:,m) = Pt - repmat(x_bar(:,m),1,size(Pt,2));        %过渡参数

               sumPt(:,:,m) = (repmat(eij(m,:),[x_dim,1]).*detPt(:,:,m))*detPt(:,:,m)'+ eye(x_dim); %parameter参数
               P(:,:,m) = wishrnd(inv(sumPt(:,:,m)),x_dim+n(m));                   %sampling covariances 采样方差 
               cov_Pt(:,:,m) = inv(P(:,:,m)); 
               miu(:,m) = x_bar(:,m)+ chol(cov_Pt(:,:,m))*randn(x_dim,1)/(1+n(m));  %sampling means.采样均值
           end

%            plot(Pt(1,:),Pt(2,:),'.k');   
%            hold on;
%            for m=1:cnum
%                [ex1,ey1,ex2,ey2] = Get_Ellipse(miu(:,m),cov_Pt(:,:,m)); %利用采样的均值和方差进行采样  
%                plot(ex1,ey1,'b',ex2,ey2,'b');  %画圈，聚类圈
%            end
          
%          title(['Times:',num2str(k)]);  %显示Times=k
         hold off;
%          pause(0.0001);
         %disp(['n=',num2str(k),' wi= ', num2str(wi)]);
     end
%      AICv(i) = 2*sum(-log(sum_wi)) + 2*cnum*7;           %AIC优化
%      BICv(i) = 2*sum(-log(sum_wi)) + cnum*7*log(Num);    %BIC优化
end
hold on;
plot(Pt(1,:),Pt(2,:),'.k');   
hold on;
for m=1:cnum
   [ex1,ey1,ex2,ey2] = Get_Ellipse(miu(:,m),cov_Pt(:,:,m)); %利用采样的均值和方差进行采样  
   plot(ex1,ey1,'g',ex2,ey2,'g','LineWidth', 1.5);  %画圈，聚类圈
end




% save FMM_parameter.mat wi miu cov_Pt AICv BICv I -append;%保存-将工作区变量保存到文件.此matlab函数将当前工作区中的所有变量保存在matlab中。
%                                                                                                %格式化的二进制文件（mat文件）称为文件名。
% load FMM_parameter.mat;

% % figure; 
% % plot(I,AICv,'-*k',I,BICv,'-sk');
% % legend('AIC优化准则','BIC优化准则');     %%有错
% % xlabel('分布元个数');
% % ylabel('信息优化准则');

% figure; 
% hold on;
% for i=1:size(I,2)
%     plot(logBICv(i,2:k),'.-k');
%     text(K-20,logBICv(i,K)-5,['num=',num2str(I(i))]);
% end
% xlabel('迭代步数');
% ylabel('BIC信息优化准则');
% t_end = cputime;
% t_total = t_end - t_start;
% 
% 
% 
% 
% figure; 
% plot(I,BICv);
% 
% for i=1:size(I,2)
%   plot(AICv(i,2:K),'-.k');
%   text(K-20,AICv(i,K)-5,['num=',num2str(I(i))]);
% end
% 
% figure; 
% hold on;
% for i=1:size(I,2)
%   plot(BICv(i,2:K),'-.k');
%   text(K-20,BICv(i,K)-5,['num=',num2str(I(i))]);
% end
% 
% ellipse points


      
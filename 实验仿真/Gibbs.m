function Gibbs2()
clear all;
t_start = cputime;      % ����ʱ��
load dianzi2.mat;        % data file
load matlab3.mat;        % data file
% Num = size(Pt,2);       % Pt: �۲����� ,  Num=3000, PtΪ2��3000�еľ���
x_dim = size(Pt,1);     % x_dimΪ����2
x_min = min(Pt(1,:));   % x_minΪ��һ������С����
x_max = max(Pt(1,:));   % x_maxΪ��һ����������
y_min = min(Pt(2,:));   % y_minΪ�ڶ�������С����
y_max = max(Pt(2,:));   % y_maxΪ�ڶ�����������
I = 2:3;
K = 100;                %iterative times  ��������100           
% logBICv = zeros(3,K);   %3*100�������
plot(true_hh.mixture_comp{1}, 'LineWidth', 1.5); 
hold on
plot(true_hh.mixture_comp{2}, 'LineWidth', 1.5); 
hold on 
plot(true_hh.mixture_comp{3}, 'LineWidth', 1.5); 
for i=1:2     
     cnum =I(i);
     for m=1:cnum
         miu(:,m) = [unifrnd(x_min,x_max,1);unifrnd(y_min,y_max,1)];   
         cov_Pt(:,:,m) = 10*[diag(ones(1,x_dim))];                         %�޶���Χ��ʼ����ֵ,����,��־�ֵ ��ָ��������ģ�͵Ĳ���
         wi(m) = 1/cnum;                                               
     end                                                               
    
     for k=1:100
           sum_wi = zeros(1,size(Pt,2));                                   %1*3000
           for m=1:cnum
               Error_x(:,:,m) = Pt - repmat(miu(:,m),1,size(Pt,2));        
               ui(m,:) = norm_pdf(Error_x(:,:,m),cov_Pt(:,:,m));           %��̬�����ܶȺ���
               sum_wi = sum_wi + wi(m)*ui(m,:);                            %sum_wiΪ��Ȼ����
           end
        
%            logBICv(i,k) = 2*sum(-log(sum_wi)) + cnum*7*log(Num);  
           for m=1:cnum                                                    %����ֵ����ݸ����ֲ�
               eij(m,:) = wi(m)*ui(m,:)./sum_wi;                           %ȱʧ����
               n(m) = sum(eij(m,:))+1;
           end
           wi = n/sum(n);                                                  %weight���ռ��

           for m=1:cnum
               x_bar(:,m) = sum((repmat(eij(m,:),2,1).*Pt)')'/n(m);        %�� 
               detPt(:,:,m) = Pt - repmat(x_bar(:,m),1,size(Pt,2));        %���ɲ���

               sumPt(:,:,m) = (repmat(eij(m,:),[x_dim,1]).*detPt(:,:,m))*detPt(:,:,m)'+ eye(x_dim); %parameter����
               P(:,:,m) = wishrnd(inv(sumPt(:,:,m)),x_dim+n(m));                   %sampling covariances �������� 
               cov_Pt(:,:,m) = inv(P(:,:,m)); 
               miu(:,m) = x_bar(:,m)+ chol(cov_Pt(:,:,m))*randn(x_dim,1)/(1+n(m));  %sampling means.������ֵ
           end

%            plot(Pt(1,:),Pt(2,:),'.k');   
%            hold on;
%            for m=1:cnum
%                [ex1,ey1,ex2,ey2] = Get_Ellipse(miu(:,m),cov_Pt(:,:,m)); %���ò����ľ�ֵ�ͷ�����в���  
%                plot(ex1,ey1,'b',ex2,ey2,'b');  %��Ȧ������Ȧ
%            end
          
%          title(['Times:',num2str(k)]);  %��ʾTimes=k
         hold off;
%          pause(0.0001);
         %disp(['n=',num2str(k),' wi= ', num2str(wi)]);
     end
%      AICv(i) = 2*sum(-log(sum_wi)) + 2*cnum*7;           %AIC�Ż�
%      BICv(i) = 2*sum(-log(sum_wi)) + cnum*7*log(Num);    %BIC�Ż�
end
hold on;
plot(Pt(1,:),Pt(2,:),'.k');   
hold on;
for m=1:cnum
   [ex1,ey1,ex2,ey2] = Get_Ellipse(miu(:,m),cov_Pt(:,:,m)); %���ò����ľ�ֵ�ͷ�����в���  
   plot(ex1,ey1,'g',ex2,ey2,'g','LineWidth', 1.5);  %��Ȧ������Ȧ
end




% save FMM_parameter.mat wi miu cov_Pt AICv BICv I -append;%����-���������������浽�ļ�.��matlab��������ǰ�������е����б���������matlab�С�
%                                                                                                %��ʽ���Ķ������ļ���mat�ļ�����Ϊ�ļ�����
% load FMM_parameter.mat;

% % figure; 
% % plot(I,AICv,'-*k',I,BICv,'-sk');
% % legend('AIC�Ż�׼��','BIC�Ż�׼��');     %%�д�
% % xlabel('�ֲ�Ԫ����');
% % ylabel('��Ϣ�Ż�׼��');

% figure; 
% hold on;
% for i=1:size(I,2)
%     plot(logBICv(i,2:k),'.-k');
%     text(K-20,logBICv(i,K)-5,['num=',num2str(I(i))]);
% end
% xlabel('��������');
% ylabel('BIC��Ϣ�Ż�׼��');
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


      
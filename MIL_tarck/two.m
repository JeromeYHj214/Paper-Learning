clc;clear;close all;
L = 50;
PD = 0.98;
range = [-1000 1000;-1000 1000];          %监测空间
num_target = 3;                           %一共3个目标
load('real_track.mat');                   %加载目标轨迹数据
n = size(X1, 2);                          %步数
num_sensor = 7;                           %传感器个数
A = [1 1 0 0;0 1 0 0;0 0 1 1;0 0 0 1];
B = [0.5 0;1 0;0 0.5;0 1];
C = [1 0 0 0;0 0 1 0];
B0 = diag([100 25 100 25]);
Q = [4 0;0 4];                            %噪声过程的协方差阵
q_std = sqrt(Q);                          %噪声过程的标准差阵
R = [100 0;0 100];                        %量测噪声协方差阵
r_std = sqrt(R);                          %量测噪声标准差阵
Sz1 = inv(R);
Sz2 = inv(R);
Sz3 = inv(R);
%-----------定义矩阵含义-------------
Xp=zeros(4,3*n);%目标状态的提前一步预测
Xe=zeros(4,3*n);%目标某时刻的估计状态
Z1=zeros(2,num_sensor,n);%目标1真实量测
Z2=zeros(2,num_sensor,n);%目标2真实量测
Z3=zeros(2,num_sensor,n);%目标3真实量测
Zp=zeros(2,3*n);%某时刻目标量测的提前一步预测
Zk=zeros(2,3*n);%认定为目标量测的集合
Pe=zeros(4,4,3*n);%滤波误差的协方差阵
Pp=zeros(4,4,3*n);%预测误差的协方差阵
K=zeros(4,2,3*n);%滤波增益
Z_prev = cell(1,n);
Z = zeros(2,3, n);
RMSE=zeros(1,3*n);
error=zeros(1,3*n);
%----------初始化3个目标的状态-------
Xe(:,1)=[-900;30;900;-30];
Xe(:,51)=[-900;25;-800;30];
Xe(:,101)=[-900;20;0;20];
Pe(:,:,1)=[100 0 0 0; 0 25 0 0;0 0 100 0;0 0 0 25];
Pe(:,:,51)=[100 0 0 0; 0 25 0 0;0 0 100 0;0 0 0 25];
Pe(:,:,101)=[100 0 0 0; 0 25 0 0;0 0 100 0;0 0 0 25];
%------------Kalman滤波跟踪过程------
for mont= 1:L
    for k = 1:n-1
        for i = 1:num_sensor
            %--三个目标的真实航迹和量测------已经保存真实航迹数据数据
            Z1(:,i,k+1)=C*X1(:,k+1)+r_std*randn(2,1);
            Z2(:,i,k+1)=C*X2(:,k+1)+r_std*randn(2,1);
            Z3(:,i,k+1)=C*X3(:,k+1)+r_std*randn(2,1);
        end
        Z_prev{1,k+1} = [Z1(:,:,k+1) Z2(:,:,k+1) Z3(:,:,k+1)];
        %% ---kalman滤波预测过程
        Xp(:,k+1)=A*Xe(:,k);%求k时刻目标1状态的提前一步预测
        Zp(:,k+1)=C*Xp(:,k+1);%求k时刻目标1量测的提前一步预测
        Pp(:,:,k+1)=A*Pe(:,:,k)*A'+B*Q*B';%求k时刻目标1预测误差的协方差阵
        Xp(:,k+51)=A*Xe(:,k+50);%求k时刻目标2状态的提前一步预测
        Zp(:,k+51)=C*Xp(:,k+51);%求k时刻目标2量测的提前一步预测
        Pp(:,:,k+51)=A*Pe(:,:,k+50)*A'+B*Q*B';%求k时刻目标2预测误差的协方差阵
        Xp(:,k+101)=A*Xe(:,k+100);%求k时刻目标3状态的提前一步预测
        Zp(:,k+101)=C*Xp(:,k+101);%求k时刻目标3量测的提前一步预测
        Pp(:,:,k+101)=A*Pe(:,:,k+100)*A'+B*Q*B';%求k时刻目标3预测误差的协方差阵
        mu = [Zp(:,k+1) Zp(:,k+51) Zp(:,k+101)]
        %% 杂波
        Nc=240;
        Zc=repmat(range(:,1),[1,Nc])+(range(1,2)-range(1,1))*rand(2,Nc);
        idx=find(rand(1,num_target*num_sensor)<=PD);
        Z_prev{1,k+1} = Z_prev{1,k+1}(:,idx);
        Z_prev{1,k+1} = [Z_prev{1,k+1} Zc];
        %%
        Z(:,:,k+1) = two_em_gmm(Z_prev{1,k+1},num_target,R,mu);
        
        %% ---观测点与目标匹配
        D = zeros(1,num_target,3*n);
        for i = 1:num_target
            D(1,i,k+1)=(Z(:,i,k+1)-Zp(:,k+1))'*Sz1*(Z(:,i,k+1)-Zp(:,k+1));   %计算k+1时刻Z_real中所有点与目标一的观测预测的距离
            D(1,i,k+51)=(Z(:,i,k+1)-Zp(:,k+51))'*Sz2*(Z(:,i,k+1)-Zp(:,k+51));%计算k+1时刻Z_real中所有点与目标二的观测预测的距离
            D(1,i,k+101)=(Z(:,i,k+1)-Zp(:,k+101))'*Sz3*(Z(:,i,k+1)-Zp(:,k+101));%计算k+1时刻Z_real中所有点与目标三的观测预测的距离
        end
        d1=min(D(1,:,k+1));%求距离中的最小值
        x=find(D(1,:,k+1)==d1);%找到最小值的位置 目标1
        d2=min(D(1,:,k+51));%目标2
        y=find(D(1,:,k+51)==d2);
        d3=min(D(1,:,k+101));%目标3
        z=find(D(1,:,k+101)==d3);
        %------kalman滤波更新过程
        Zk(:,k+1)=Z(:,x(1),k+1);%获取目标1的新的量测
        Sk1=(C*Pp(:,:,k+1)*C'+R);
        K(:,:,k+1)=Pp(:,:,k+1)*C'*inv(Sk1);%k时刻系统的滤波增益
        a=Zk(:,k+1)-Zp(:,k+1);%新息
        Zk(:,k+51)=Z(:,y(1),k+1);%获取目标2的新量测
        Sk2=(C*Pp(:,:,k+51)*C'+R);
        K(:,:,k+51)=Pp(:,:,k+51)*C'*inv(Sk2);
        b=Zk(:,k+51)-Zp(:,k+51);%新息
        Zk(:,k+101)=Z(:,z(1),k+1);%获取目标3的新量测
        Sk3=(C*Pp(:,:,k+101)*C'+R);
        K(:,:,k+101)=Pp(:,:,k+101)*C'*inv(Sk3);
        c=Zk(:,k+101)-Zp(:,k+101);%新息
        Xe(:,k+1)=Xp(:,k+1)+K(:,:,k+1)*a;%目标1的滤波更新值
        Pe(:,:,k+1)=Pp(:,:,k+1)-K(:,:,k+1)*C*Pp(:,:,k+1);%目标1的滤波误差的协方差
        Xe(:,k+51)=Xp(:,k+51)+K(:,:,k+51)*b;%目标2的滤波更新值
        Pe(:,:,k+51)=Pp(:,:,k+51)-K(:,:,k+51)*C*Pp(:,:,k+51);%目标2的滤波误差的协方差阵
        Xe(:,k+101)=Xp(:,k+101)+K(:,:,k+101)*c;%目标3的滤波更新值
        Pe(:,:,k+101)=Pp(:,:,k+101)-K(:,:,k+101)*C*Pp(:,:,k+101);%目标3的滤波误差的协方差阵
        %% 跟踪误差计算
        error(1,k+1)=sum((Xe([1 3],k+1)-X1([1 3],k+1)).^2);
        error(1,k+51)=sum((Xe([1 3],k+51)-X2([1 3],k+1)).^2);
        error(1,k+101)=sum((Xe([1 3],k+101)-X3([1 3],k+1)).^2);
        
        %% 绘制实时跟踪图
%             clf;  hold on;%Zk量测 ，Zp提前一步量测的预测，Xe目标状态估计，X1目标真实状态
%             % plot 真实轨迹
%             plot(X1(1,2:k+1),X1(3,2:k+1),'-r','LineWidth',1.6);
%             plot(X2(1,2:k+1),X2(3,2:k+1),'--g','LineWidth',1.6);
%             plot(X3(1,2:k+1),X3(3,2:k+1),':b','LineWidth',1.6);
%             %plot 估计轨迹
%             plot(Xe(1,2:k+1),Xe(3,2:k+1),'k-+','LineWidth',1.2);
%             plot(Xe(1,52:k+51),Xe(3,52:k+51),'k-^','LineWidth',1.2);
%             plot(Xe(1,102:k+101),Xe(3,102:k+101),'k-o','LineWidth',1.2);
%             plot(Zc(1,:),Zc(2,:),'k*','LineWidth',1.6);
%             % axis(equal);axis(limit);
%             xlabel('X/m','fontsize',10);ylabel('Y/m','fontsize',10);
%             legend('目标1真实轨迹','目标2真实轨迹','目标3真实轨迹','目标1估计轨迹','目标2估计轨迹','目标3估计轨迹');
%             hold off;
%             pause(0.01);
    end
    %% 蒙特卡洛仿真误差累加
    RMSE=RMSE+error/L;
end
%% 更新RMSE
RMSE=sqrt(RMSE);
%% 分别绘制RMSE
figure;hold on;
plot(RMSE(1:n),'-r','LineWidth',1.6);
plot(RMSE(n+1:2*n),'--g','LineWidth',1.6);
plot(RMSE(2*n+1:3*n),':b','LineWidth',1.6);
xlabel('时间/(s)','fontsize',10);ylabel('RMSE/(m)','fontsize',10);
legend('目标1','目标2','目标3');
hold off;
%% 单独真实轨迹
figure;hold on;
plot(X1(1,2:k+1),X1(3,2:k+1),'-r','LineWidth',1.6);
plot(X2(1,2:k+1),X2(3,2:k+1),'--g','LineWidth',1.6);
plot(X3(1,2:k+1),X3(3,2:k+1),':b','LineWidth',1.6);
xlabel('X/m','fontsize',10);ylabel('Y/m','fontsize',10);
legend('目标1真实轨迹','目标2真实轨迹','目标3真实轨迹');
hold off;
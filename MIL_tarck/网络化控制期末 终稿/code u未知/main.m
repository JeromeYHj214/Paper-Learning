clear all; close all; clc;
delta_t = 0.1;              %测量周期，采样周期
tf = 20;                    %时间长度2s
T = tf / delta_t;           %一共采样200次
N = 1000;                    %粒子总数
R = 0.1;
Range = 100;                %取值范围
P = zeros(3, N);            %建立粒子群
PCenter = zeros(3, T);      %所有粒子的中心位置
w = zeros(N, 1);            %每个粒子的权重
%err = zeros(1,T);    %误差
lh = zeros(N,1);
Co = [0, 10, 0;
    0, 0, 10];
%概率转移矩阵
Po = [0.9, 0.05, 0.05;
    0.05, 0.9, 0.05;
    0.05, 0.05, 0.9];
% 状态转移矩阵F
F = [ 1, 0, 0, delta_t, 0;
    0, 1, 0, 0, delta_t;
    0, 0, 1, 0, 0;
    0, 0, 0, 1, 0;
    0, 0, 0, 0, 1 ];
% 控制驱动矩阵B
B = [ (delta_t^2)/2, 0;
    0, (delta_t^2)/2;
    0, 0;
    delta_t, 0;
    0, delta_t ];
% 噪声驱动矩阵G
G = [ (delta_t^2)/2, 0, 0;
    0, (delta_t^2)/2, 0;
    0, 0, delta_t;
    delta_t, 0, 0;
    0, 0, delta_t ];

Q = zeros(3, T);
Q(:, 1) = 100*rand(3, 1);
lh(1) = sum(Q(:, 1));
Q = Q/lh(1);
%初始化粒子群  PF滤波
for i = 1 : N
    P(:, i) = [Range*rand;Range*rand;Range*rand];
    lh(i) = sum(P(:, i));
    P(:, i) =  P(:, i)/lh(i);
    dist = norm(P(:, i)-Q(:, 1));    %与测量位置相差的距离
    w(i) = (1 / sqrt(R) / sqrt(2 * pi)) * exp(-(dist)^2 / 2 / R);   %求权重
end
PCenter(:, 1) = sum(P, 2) / N;     %所有粒子的几何中心位置
%err(1) = norm(Q(:, 1) - PCenter(:, 1));    %粒子几何中心与系统真实状态的误差
% figure(1);
% set(gca,'FontSize',12);
% hold on
% plot3(Q(1, 1), Q(2, 1), Q(3, 1), 'r.', 'markersize',30)   %系统状态位置
% plot3(P(1, :), P(2, :), P(3, :), 'k.', 'markersize',5);   %各个粒子位置
% plot3(PCenter(1, 1), PCenter(2, 1), PCenter(2, 1), 'b.', 'markersize',25); %所有粒子的中心位置
% legend('True State', 'Particles', 'The Center of Particles');
% title('Initial State');
% view(3);
% hold off
for k = 2:T
    Q(:, k) = Po*Q(:, k - 1);
    %粒子滤波
    %预测
    for i = 1 : N
        P(:, i) = Po*P(:, i);
        dist = norm(P(:, i)-Q(:, k));    %与测量位置相差的距离
        w(i) = (1 / sqrt(R) / sqrt(2 * pi)) * exp(-(dist)^2 / 2 / R);   %求权重
    end
    %归一化权重
    wsum = sum(w);
    for i = 1 : N
        w(i) = w(i) / wsum;
    end
    
    %重采样（更新）
    for i = 1 : N
        wmax = 2 * max(w) * rand;  %另一种重采样规则
        index = randi(N, 1);
        while(wmax > w(index))
            wmax = wmax - w(index);
            index = index + 1;
            if index > N
                index = 1;
            end
        end
        P(:, i) = P(:, index);    %得到新粒子
    end
    PCenter(:, k) = sum(P, 2) / N;     %所有粒子的中心位置
    %计算误差
    %     err(k) = norm(Q(:, k) - PCenter(:, k));    %粒子几何中心与系统真实状态的误差
    %     figure(2);
    %     set(gca,'FontSize',12);
    %     clf;
    %     hold on
    %     plot3(Q(1, k), Q(2, k), Q(3, k), 'r.', 'markersize',50); %系统状态位置
    %     plot3(P(1, :), P(2, :), P(3, :), 'k.', 'markersize',5);   %各个粒子位置
    %     plot3(PCenter(1, k), PCenter(2, k), PCenter(3, k), 'b.', 'markersize',25); %所有粒子的中心位置
    %     legend('True State', 'Particle', 'The Center of Particles');
    %     hold off
    %     view(3);
    %     pause(0.1);
end

% figure(3);
% set(gca,'FontSize',12);
% plot3(Q(1,:), Q(2,:),  Q(3,:), 'r', PCenter(1,:), PCenter(2,:), PCenter(3,:), 'b-');
% legend('True State', 'Particle Filter');
% xlabel('x', 'FontSize', 20); ylabel('y', 'FontSize', 20); zlabel('z', 'FontSize', 20);
%
% figure(4);
% set(gca,'FontSize',12);
% plot(err,'.-');
% xlabel('t', 'FontSize', 20);
% title('The err');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EKF滤波
for i = 1:1000
    x = zeros(5, T);
    x(:,1) = [ 300, 400, 100, 50, 80]';    %初始状态X（0）
    ex = zeros(5, T);
    ex(:,1) = [ 250, 350, 90, 40, 60]';    %滤波器状态Xekf（0）
    cigema = sqrt(0.2);
    w = cigema*randn(3,T);          %过程噪声
    Q = cigema^2*eye(3);
    d = sqrt(0.1);
    v = d*randn(2, T);              %观测噪声
    R = d^2*eye(2);
    z = zeros(2, T);
    z(:,1) = [sqrt(x(1,1)^2 + x(2,1)^2 + x(3,1)^2),...
        atan(x(2, 1)/x(1, 1))]' + v(:,1);
    u = zeros(2, T);
    u(:, 1) = driver(PCenter(:, 1), Co);
    for k = 2:T
        u(:, k) = driver(PCenter(:, k), Co);
        x(:,k) = F*x(:,k-1)+B*u(:,k-1)+G*w(:,k-1);
        z(:,k) = [sqrt(x(1,k)^2 + x(2,k)^2 + x(3,k)^2),...
            atan(x(2, k)/x(1, k))]' + v(:,k) ;
    end
    %下面开始滤波
    P0 = 0.1 * eye(5);
    eP0 = P0;
    for k = 2:T
        [ex(:,k),eP0] = ekf(F,B,G,Q,R,eP0,u(:,k-1),z(:,k),ex(:,k-1));
    end
    for t=1:T
        Ep_ekfx(i,t) = sqrt((ex(1,t) - x(1,t))^2);
        Ep_ekfy(i,t) = sqrt((ex(2,t) - x(2,t))^2);
        Ep_ekfz(i,t) = sqrt((ex(3,t) - x(3,t))^2);
        Ev_ekfx(i,t) = sqrt((ex(4,t) - x(4,t))^2);
        Ev_ekfy(i,t) = sqrt((ex(5,t) - x(5,t))^2);
        Ep_ekf(i,t) = sqrt( (ex(1,t) - x(1,t))^2 + (ex(2,t) - x(2,t))^2 + (ex(3,t) - x(3,t))^2 );
        Ev_ekf(i,t) = sqrt( (ex(4,t) - x(4,t))^2 + (ex(5,t) - x(5,t))^2 );
    end
    for t=1:T
        error_x(t) = mean(Ep_ekfx(:,t));
        error_y(t) = mean(Ep_ekfy(:,t));
        error_z(t) = mean(Ep_ekfz(:,t));
        error_xv(t) = mean(Ev_ekfx(:,t));
        error_yv(t) = mean(Ev_ekfy(:,t));
        error_r(t) = mean(Ep_ekf(:,t));
        error_v(t) = mean(Ev_ekf(:,t));
    end
    
end
% sum = 0;
% for t  = 1:T
%     aa = sqrt( (ex(1,t) - x(1,t))^2 + (ex(2,t) - x(2,t))^2 + (ex(3,t) - x(3,t))^2+(ex(4,t) - x(4,t))^2 + (ex(5,t) - x(5,t))^2 );
%     sum = sum + aa;
% end
% meanerror = sum/T
t = 0.1:0.1:20;
figure
hold on;box on;grid on;
plot3(x(1,:),x(2,:),x(3,:),'-k.')

plot3(ex(1,:),ex(2,:),ex(3,:),'-r.','MarkerFace','r')
legend('真实值', 'EKF滤波值');
view(3)
xlabel('x/m');
ylabel('y/m');
zlabel('z/m');
figure
hold on;box on;grid on;
plot(t,error_r,'b');
xlabel('运动时间/s');
ylabel('相对距离估计误差/m');
figure
hold on;box on;grid on;
plot(t,error_v,'b');
xlabel('运动时间/s');
ylabel('速度估计误差m/s');
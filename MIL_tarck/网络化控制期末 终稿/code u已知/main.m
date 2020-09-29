%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
delta_t = 0.1;             %�������ڣ���������
tf = 10;                     %ʱ�䳤��tfs
T = tf / delta_t;           %һ������T��
% ״̬ת�ƾ���F
F = [ 1, 0, 0, delta_t, 0;
      0, 1, 0, 0, delta_t;
      0, 0, 1, 0, 0;
      0, 0, 0, 1, 0;
      0, 0, 0, 0, 1 ];
% ������������B
B = [ (delta_t^2)/2, 0;
      0, (delta_t^2)/2;
      0, 0;
      delta_t, 0;
      0, delta_t ];
% ������������G
G = [ (delta_t^2)/2, 0, 0;
      0, (delta_t^2)/2, 0;
      0, 0, delta_t;
      delta_t, 0, 0;
      0, 0, delta_t ];
% ����ת�ƾ���
P = [0.9, 0.05, 0.05;
     0.05, 0.9, 0.05;
     0.05, 0.05, 0.9];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:1000
  x = zeros(5, T);
  x(:,1) = [ 300, 400, 100, 50, 80]';    %��ʼ״̬X��0��
  ex = zeros(5, T);
  ex(:,1) = [ 250, 350, 90, 40, 60]';    %�˲���״̬Xekf��0��
  cigema = sqrt(0.2);
  w = cigema*randn(3,T);          %��������
  Q = cigema^2*eye(3);
  d = sqrt(0.1);
  v = d*randn(2, T);              %�۲�����
  R = d^2*eye(2);
  z = zeros(2, T);
  z(:,1) = [sqrt(x(1,1)^2 + x(2,1)^2 + x(3,1)^2),...
            atan(x(2, 1)/x(1, 1))]' + v(:,1);
  u1 = ones(1, T);
  u2 = zeros(1, T);
  u = 10*[u1;u2];
  for k = 2:T
    x(:,k) = F*x(:,k-1)+B*u(:,k-1)+G*w(:,k-1);
    z(:,k) = [sqrt(x(1,k)^2 + x(2,k)^2 + x(3,k)^2),...
            atan(x(2, k)/x(1, k))]' + v(:,k) ;
  end    
  %���濪ʼ�˲�
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
%     for t  = 1:T
%        aa = sqrt( (ex(1,t) - x(1,t))^2 + (ex(2,t) - x(2,t))^2 + (ex(3,t) - x(3,t))^2+(ex(4,t) - x(4,t))^2 + (ex(5,t) - x(5,t))^2 );
%        sum = sum + aa;
%     end
%      meanerror = sum/T
t = 0.1:0.1:10;
figure
hold on;box on;grid on;
plot3(x(1,:),x(2,:),x(3,:),'-k.')
plot3(ex(1,:),ex(2,:),ex(3,:),'-r.','MarkerFace','r')
legend('��ʵֵ', 'EKF�˲�ֵ');
view(3)
xlabel('x/m');
ylabel('y/m');
zlabel('z/m');
figure
hold on;box on;grid on;
plot(t,error_r,'b');
xlabel('�˶�ʱ��/s');
ylabel('��Ծ���������/m');
figure
hold on;box on;grid on;
plot(t,error_v,'b');
xlabel('�˶�ʱ��/s');
ylabel('�ٶȹ������m/s');
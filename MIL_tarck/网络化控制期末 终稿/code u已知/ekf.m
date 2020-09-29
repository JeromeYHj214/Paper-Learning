function [ex,P0] = ekf(F,B,G,Q,R,P0,u,z,ex)
Xn = F*ex + B*u;
P = F*P0*F'+ G*Q*G';
dh1_dx = Xn(1)/sqrt(Xn(1)^2 + Xn(2)^2 + Xn(3)^2);
dh1_dy = Xn(2)/sqrt(Xn(1)^2 + Xn(2)^2 + Xn(3)^2);
dh1_dz = Xn(3)/sqrt(Xn(1)^2 + Xn(2)^2 + Xn(3)^2);
dh2_dx = -1*Xn(2)/(Xn(1)^2 + Xn(2)^2);
dh2_dy = Xn(1)/(Xn(1)^2 + Xn(2)^2);
dh2_dz = 0;
H = [dh1_dx,dh1_dy,dh1_dz,0,0;dh2_dx,dh2_dy,dh2_dz,0,0];

K = P*H'/(H*P*H'+ R);
ex = Xn + K*(z - H*Xn);
P0 = (eye(5) - K*H)*P; 
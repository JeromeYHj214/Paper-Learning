% %% 第一类点模式
% num_X1 = 5;
% 
% m_X1_x1 = [1; 1];
% S_X1_x1 = [2 0; 0 2];
% X1_x1 = mvnrnd(m_X1_x1, S_X1_x1, N)';
% 
% m_X1_e1 = [0; 0];
% S_X1_e1 = 3*[1 0; 0 1];
% X1_e1 = mvnrnd(m_X1_e1, S_X1_e1,N)';
% X1_x2 = X1_x1 + X1_e1;
% 
% m_X1_e2 = [0; 0];
% S_X1_e2 = 4*[1 0; 0 1];
% X1_e2 = mvnrnd(m_X1_e2, S_X1_e2,N)';
% X1_x3 = X1_x2 + X1_e2;
% 
% m_X1_e3 = [0; 0];
% S_X1_e3 = 5*[1 0; 0 1];
% X1_e3 = mvnrnd(m_X1_e3, S_X1_e3,N)';
% X1_x4 = X1_x3 + X1_e3;
% 
% m_X1_e4 = [0; 0];
% S_X1_e4 = 6*[1 0; 0 1];
% X1_e4 = mvnrnd(m_X1_e4, S_X1_e4,N)';
% X1_x5 = X1_x4 + X1_e4;
% 
% X1 = zeros(dimension, num_X1, N);
% for i = 1:N
%     X1(:, 1, i)  = X1_x1(:,i);
% end
% 
% for i = 1:N
%     X1(:, 2, i)  = X1_x2(:,i);
% end
% 
% for i = 1:N
%     X1(:, 3, i)  = X1_x3(:,i);
% end
% 
% for i = 1:N
%     X1(:, 4, i)  = X1_x4(:,i);
% end
% 
% for i = 1:N
%     X1(:, 5, i)  = X1_x5(:,i);
% end
% 
% figure(1);
% for i = 1:N
%     plot(X1(1,:,i), X1(2,:,i));
%     hold on;
% end
% 
% %% 第二类点模式
% num_X2 = 5;
% 
% m_X2_x1 = [1; 1];
% S_X2_x1 = [2 0; 0 2];
% X2_x1 = mvnrnd(m_X2_x1, S_X2_x1, N)';
% 
% m_X2_e1 = [0; 0];
% S_X2_e1 = 3*[1 0; 0 1];
% X2_e1 = mvnrnd(m_X2_e1, S_X2_e1,N)';
% X2_x2 = X2_x1 + X2_e1;
% 
% m_X2_e2 = [0; 0];
% S_X2_e2 = 4*[1 0; 0 1];
% X2_e2 = mvnrnd(m_X2_e2, S_X2_e2,N)';
% X2_x3 = X2_x2 + X2_e2;
% 
% m_X2_e3 = [0; 0];
% S_X2_e3 = 5*[1 0; 0 1];
% X2_e3 = mvnrnd(m_X2_e3, S_X2_e3,N)';
% X2_x4 = X2_x1 + X2_e3;
% 
% m_X2_e4 = [0; 0];
% S_X2_e4 = 6*[1 0; 0 1];
% X2_e4 = mvnrnd(m_X2_e4, S_X2_e4,N)';
% X2_x5 = X2_x4 + X2_e4;
% 
% X2 = zeros(dimension, num_X2, N);
% for i = 1:N
%     X2(:, 1, i)  = X2_x1(:,i);
% end
% 
% for i = 1:N
%     X2(:, 2, i)  = X2_x2(:,i);
% end
% 
% for i = 1:N
%     X2(:, 3, i)  = X2_x3(:,i);
% end
% 
% for i = 1:N
%     X2(:, 4, i)  = X2_x4(:,i);
% end
% 
% for i = 1:N
%     X2(:, 5, i)  = X2_x5(:,i);
% end
% 
% figure(2);
% for i = 1:N
%     plot(X2(1,:,i), X2(2,:,i));
%     hold on;
% end
% 
% %% 第三类点模式
% num_X3 = 5;
% 
% m_X3_x1 = [1; 1];
% S_X3_x1 = [2 0; 0 2];
% X3_x1 = mvnrnd(m_X3_x1, S_X3_x1, N)';
% 
% m_X3_e1 = [0; 0];
% S_X3_e1 = 3*[1 0; 0 1];
% X3_e1 = mvnrnd(m_X3_e1, S_X3_e1,N)';
% X3_x2 = X3_x1 + X3_e1;
% 
% m_X3_e2 = [0; 0];
% S_X3_e2 = 4*[1 0; 0 1];
% X3_e2 = mvnrnd(m_X3_e2, S_X3_e2,N)';
% X3_x3 = X3_x2 + X3_e2;
% 
% m_X3_e3 = [0; 0];
% S_X3_e3 = 5*[1 0; 0 1];
% X3_e3 = mvnrnd(m_X3_e3, S_X3_e3,N)';
% X3_x4 = X3_x3 + X3_e3;
% 
% m_X3_e4 = [0; 0];
% S_X3_e4 = 6*[1 0; 0 1];
% X3_e4 = mvnrnd(m_X3_e4, S_X3_e4,N)';
% X3_x5 = X3_x3 + X3_e4;
% 
% X3 = zeros(dimension, num_X3, N);
% for i = 1:N
%     X3(:, 1, i)  = X3_x1(:,i);
% end
% 
% for i = 1:N
%     X3(:, 2, i)  = X3_x2(:,i);
% end
% 
% for i = 1:N
%     X3(:, 3, i)  = X3_x3(:,i);
% end
% 
% for i = 1:N
%     X3(:, 4, i)  = X3_x4(:,i);
% end
% 
% for i = 1:N
%     X3(:, 5, i)  = X3_x5(:,i);
% end
% 
% figure(3);
% for i = 1:N
%     plot(X3(1,:,i), X3(2,:,i));
%     hold on;
% end

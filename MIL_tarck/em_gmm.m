%     Z_prev(:,:,k+1) = [Z1(:,:,k+1) Z2(:,:,k+1) Z3(:,:,k+1)];
%     Z(k+1) = em_gmm(Z_prev(k+1));
function Z = em_gmm(Z_prev,num_target,R)
%UNTITLED4 此处显示有关此函数的摘要
%   Z_prev为维度*长度
a = size(Z_prev);
s = a(2);%总粒子数
d = a(1);%特征维度
b = s / num_target; %传感器数目
L = [];%存储标签
mu_prev = zeros(num_target,d);
sigma_prev = zeros(d,d,num_target);

for i = 1:num_target
    he = 0;
    for j = (i-1)*b+1 : i*b
        he = Z_prev(:,j) + he;
    end
    mu_prev(i,:) = he' / b;
end

for i = 1:num_target
    sigma_prev(:,:,i) = R;
end

alpha_prev = ones(1,num_target)/num_target;
R = fix(b*alpha_prev);

for i = 1:num_target
    L = [L;ones(R(i), 1)*i];
end

MaxIter = 50;
response = zeros([s num_target]);

next_mu = zeros(size(mu_prev));
next_Sigma = zeros(size(sigma_prev));

% plot(Z_prev(1,:),Z_prev(2,:),'o');
% axis([-1000 1000 -1000 1000]);

% -----------------------------
% The EM loop
% -----------------------------
for t = 1:MaxIter
    t
   
    if t > 1
    
        % -----------------------------
        % Compute the responsibilities
        % -----------------------------

        for l = 1:num_target
            response(:,l) = mvnpdf(Z_prev',mu_prev(l,:), sigma_prev(:,:,l)); 
        end

        response_sum = sum(response,2);
        response = response ./ repmat(response_sum,[1 num_target]);

        % ---------------------------
        % update alpha^(i+1)
        % ---------------------------

        next_alpha = sum(response)'/s;

        % ---------------------------
        % update mu^(i+1)
        % ---------------------------

        for l = 1:num_target
            next_mu(l,:) = sum(Z_prev' .* repmat(response(:,l),[1 d])) / sum(response(:,l));
        end

        % ---------------------------
        % update Sigma^(i+1)
        % ---------------------------

        for l = 1:num_target
            zero_mean_data = Z_prev' - repmat(next_mu(l,:),[s 1]);
            %zero_mean_3d = reshape(zero_mean_data,[N 1 d]);

            covariances = zeros([d d s]);

            for i = 1:s
                covariances(:,:,i) = zero_mean_data(i,:)' * zero_mean_data(i,:) * response(i,l);
            end

            next_Sigma(:,:,l) = sum(covariances,3)/sum(response(:,l));        
        end

        mu_prev     = next_mu
        sigma_prev  = next_Sigma;
        alpha_prev  = next_alpha;
    
    
    else
        
        % t = 1, just use initial parameters
        
        next_mu     = mu_prev;
        next_Sigma  = sigma_prev;
        next_alpha  = alpha_prev;
        
    end
    
    % -----------------------------
    % plot GMM
    % -----------------------------
%     figure(1);
%     plot(Z_prev(1,:), Z_prev(2,:), 'o');   
%     axis([-1000 1000 -1000 1000]); 
%     hold on;
%         
%     gmm_pdf = gmdistribution(next_mu,next_Sigma,next_alpha); 
%     fcontour(@(u,v)pdf(gmm_pdf,[u v]));
%     hold off; 
    %---------输出
    Z = mu_prev';
  

end


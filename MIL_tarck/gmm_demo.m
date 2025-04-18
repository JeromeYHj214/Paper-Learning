% --------------------------------------
% Gausssian Mixture Model demos
% written by Richard Xu
% yida.xu@uts.edu.au, July, 2014
% made it Octave-friendly
% --------------------------------------

clc;
clear;
close;


% ------------------------------------------------------
% Synthetically generate data from nominated parameters
% ------------------------------------------------------

% N is the number of data
N           = 40;
gt_alpha    = [1/4 1/4 1/4 1/4];

% M is K, means the number of clusters
M           = length(gt_alpha);


% Sample Z ~ Mult(N,gt_alpha)

Z = [];

% drawing from a multinomial distribution, parameterised by gt_alpha
% R1 = mnrnd(N,gt_alpha);

R = fix(N * gt_alpha);


for t = 1:M
    Z = [Z; ones([R(t) 1])*t];
end


% Simulate data from ground truth N ( theta_{z_1},....,theta_{z_n}

mu = [ -3 4; 0 0; 3 4; 2 2];
Sigma(:,:,1) = [ 100 0; 0 100];
Sigma(:,:,2) = [ 100 0; 0 100];
Sigma(:,:,3) = [ 100 0; 0 100];
Sigma(:,:,4) = [ 100 0; 0 100];

% data is X = {x_1, .... x_n}
data = zeros([N 2]);

for t = 1:M
   comp_size = length(find(Z == t));
   data(Z == t,:) = mvnrnd(mu(t,:), Sigma(:,:,t), comp_size);
   
   plot(data(:,1),data(:,2),'o');
end



% -------------------------------------------------
% E-M algorithm
% -------------------------------------------------

% initialize, i.e., nominate Theta^(1)
prev_mu = [ -3.2 3.8; 0.1 0.1; 4 4; 3 3];
prev_Sigma(:,:,1) = [ 95 0; 0 95];
prev_Sigma(:,:,2) = [ 95 0; 0 95];
prev_Sigma(:,:,3) = [ 95 0; 0 95];
prev_Sigma(:,:,4) = [ 95 0; 0 95];
prev_alpha = ones([M 1])/M;


% the iteration number 
MaxIter = 10;
response = zeros([N M]);

next_mu = zeros(size(prev_mu));
next_Sigma = zeros(size(prev_Sigma));
d = size(data,2);

% -----------------------------
% The EM loop
% -----------------------------
for t = 1:MaxIter
   
    if t > 1
    
        % -----------------------------
        % Compute the responsibilities
        % -----------------------------

        for l = 1:M
            response(:,l) = mvnpdf(data,prev_mu(l,:), prev_Sigma(:,:,l)); 
        end

        response_sum = sum(response,2);
        response = response ./ repmat(response_sum,[1 4]);

        % ---------------------------
        % update alpha^(i+1)
        % ---------------------------

        next_alpha = sum(response)'/N;

        % ---------------------------
        % update mu^(i+1)
        % ---------------------------

        for l = 1:M
            next_mu(l,:) = sum(data .* repmat(response(:,l),[1 d])) / sum(response(:,l));
        end

        % ---------------------------
        % update Sigma^(i+1)
        % ---------------------------

        for l = 1:M
            zero_mean_data = data - repmat(next_mu(l,:),[N 1]);
            %zero_mean_3d = reshape(zero_mean_data,[N 1 d]);

            covariances = zeros([d d N]);

            for i = 1:N
                covariances(:,:,i) = zero_mean_data(i,:)' * zero_mean_data(i,:) * response(i,l);
            end

            next_Sigma(:,:,l) = sum(covariances,3)/sum(response(:,l));        
        end

        prev_mu     = next_mu;
        prev_Sigma  = next_Sigma;
        prev_alpha  = next_alpha;
    
    
    else
        
        % t = 1, just use initial parameters
        
        next_mu     = prev_mu;
        next_Sigma  = prev_Sigma;
        next_alpha  = prev_alpha;
        
    end
    
    % -----------------------------
    % plot GMM
    % -----------------------------
    figure(1);
    plot(data(:,1), data(:,2), 'o');   
    axis([min(data(:,1)) max(data(:,1)) min(data(:,2)) max(data(:,2))]); 
    hold on;
        
    gmm_pdf = gmdistribution(next_mu,next_Sigma,next_alpha); 
    fcontour(@(u,v)pdf(gmm_pdf,[u v]));

    
    % -----------------------------------------------
    % Octave-friendly code
    % -----------------------------------------------

%     x1 = min(data(:,1)):0.1:max(data(:,1));
%     x2 = min(data(:,2)):0.1:max(data(:,2));    
%     [X1,X2] = meshgrid(x1,x2);
%     F = next_alpha(1) * mvnpdf([X1(:) X2(:)],next_mu(1,:),next_Sigma(:,:,1));
%     for l = 2:M
%        F = F+ next_alpha(l) * mvnpdf([X1(:) X2(:)],next_mu(l,:),next_Sigma(:,:,l));
%     end
%     F = reshape(F,length(x2),length(x1));
%     contour(x1,x2,F);

    
%     axis([min(data(:,1)) max(data(:,1)) min(data(:,2)) max(data(:,2))]); 
    hold off; 
    
    % this is to ask user to press a button
    % waitforbuttonpress;
     
end



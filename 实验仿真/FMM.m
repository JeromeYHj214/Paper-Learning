% day 9月27号
%% prepare workspace
clear class;
construct_all_distributions();
clearvars;
close all;
%% initialisation
visualise_gaussian = [1 2 3 4 5]; % an array flag to visualise the Gaussian distributions
% 1: ground-truth; 2: initialised model; 3: learned model
num_components = 3; % num of mixture components
num_obs = 100; % num of observations
dim_obs = 2; % dimension of each observations
%% synthesise data
% mixing proportions
true_hh.mixing_prop = mk_stochastic(rand([num_components, 1]));
% mixture components
true_mu = cell(1, num_components);
true_cov = cell(1, num_components);
true_rate = cell(1, num_components); % for RFS
% cluster #1
true_mu{1} = [0;10];
true_cov{1} = [5 -1;-1 3];
true_rate{1} = 30;
% cluster #2
true_mu{2} = [3;8];
true_cov{2} = [3 -2;-2 3];
true_rate{2} = 24;
% cluster #3
true_mu{3} = [7;11];
true_cov{3} = [6 -2;-2 3];
true_rate{3} = 20;

% true_mu{4} = [2;8];
% true_cov{4} = [3 -2;-2 3];
% true_rate{4} = 16;
% 
% true_mu{5} = [12;8];
% true_cov{5} = [6 -2;-2 3];
% true_rate{5} = 13;
%构造出混合模型
for ii = 1:num_components
    true_hh.mixture_comp{ii} = GenericRFS(Poisson(true_rate{ii}), Gaussian(true_mu{ii}, true_cov{ii}));
end
% ground-truth mixture model真实的混合模型
true_mm = MixtureModel(true_hh); 
%真实的混合模型出产生100个点模式数据
[all_obs, true_cluster_ids] = sample(true_mm, num_obs);

%% print details of the ground-truth Mixture Model
fprintf('The ground-truth model:\n');
display(true_mm)

%% learn the MM from the data
% initialise the mixture model
dummy_hh.mixing_prop = ones(num_components, 1);
for ii = 1:num_components
    dummy_hh.mixture_comp{ii} = GenericRFS(Poisson(1), Gaussian(zeros(dim_obs, 1), eye(dim_obs)));
end
DD=MixtureModel(dummy_hh);
display(DD)

%初始化化一个有限集模型
init_mm = init_from_data(DD, all_obs, true);   %%%%%%%%将各部分展现出来
init =MixtureModel(init_mm);
 %%Gibbs sample
 for ii=1:5
    xx=all_obs;
    if iscell(xx)
        ww = ones(1, length(xx));
    else
    end
    ww = reshape(ww, 1, []);
    %组分比
    mixing_prop = init_mm.mixing_prop; 
    %组分模型
    mixture_comp = init_mm.mixture_comp;   
    % % mixing proportion随机产生混合比
    % mixing_prop = mk_stochastic(rand(1, num_comp));
    % 估计概率---->指示变量
    for kk = 1:num_components
        tmp_tau = zeros(1, num_obs);
        for nn = 1:num_obs
            tmp_tau(nn) = log(mixing_prop(kk)) + logpdf(mixture_comp{kk}, xx{nn}); %计算log联合概率
        end
        tau(kk, :) = tmp_tau;
    end
    normalisation_factor = logsumexp(tau, 1); % 归一化因数
    tau = bsxfun(@minus, tau, normalisation_factor); % 除以相应的联合概率
    % 归一化因子得到后验概率 
    % 得到log后验概率(归一化后的概率)
    tau = bsxfun(@times, exp(tau), ww);
    mixing_prop = sum(tau, 2) / sum(tau(:));   % 重新估计混合比例
    %%GML估计高斯参数
    for kk = 1:num_components
        mixture_comp{kk} = GML(mixture_comp{kk}, xx, tau(kk, :)); % re-estimate the mixture components
    end
    init_mm.mixing_prop = mixing_prop;
    init_mm.mixture_comp = mixture_comp;
    learned_model = MixtureModel(init_mm);
 end
display(learned_model)
learned_cluster_ids = posterior(learned_model, all_obs);

%%绘图 
B=[];
for ss=1:num_obs
    A=all_obs{1,ss};
    B=[B,A];
end
Pt=B;

learned_hh = paramqq(learned_model);
init_hh = paramqq(init); 
figure(10 + length(true_hh.mixture_comp)); 
clf;
title_cells = cell(1, 4);
title_cells{4} = 'Gaussian components in the Mixture Models. ';


figure;
plot(Pt(1,:),Pt(2,:),'.k');
for ii = 1:length(true_hh.mixture_comp)
    %真实模型
    if sum(visualise_gaussian == 5)
        hold on;
        plot(true_hh.mixture_comp{ii}, 'LineWidth', 1.5); 
        title_cells{1} = 'blue = ground-truth. ';
    end
end
set(gca, 'FontSize', 12); % set the default font size for axes
hold on;

figure;
plot(Pt(1,:),Pt(2,:),'.k');
for ii = 1:length(true_hh.mixture_comp)
%Gibbs模型
    if sum(visualise_gaussian == 5)
        hold on;
        plot(learned_hh.mixture_comp{ii}, 'formatStr', 'm', 'LineWidth', 1.5);
        title_cells{1} = '';
        title_cells{3} = 'magenta = learned distributions. ';
    end
end
set(gca, 'FontSize', 12); % set the default font size for axes
% title({title_cells{4}, [title_cells{1}, title_cells{2}, title_cells{3}]}, 'FontSize', 12);


figure;
plot(Pt(1,:),Pt(2,:),'.k');
for ii = 1:length(true_hh.mixture_comp)
    %真实模型
    if sum(visualise_gaussian == 1)
        hold on
        plot(true_hh.mixture_comp{ii}, 'LineWidth', 1.5); 
        title_cells{1} = 'blue = ground-truth. ';
    end
%     %初始化模型
%     if sum(visualise_gaussian == 2)
%         plot(init_hh.mixture_comp{ii}, 'formatStr', 'k'); 
%         hold on;
%         title_cells{2} = 'black = initialised distributions. ';
%     end
    %Gibbs模型
    if sum(visualise_gaussian == 5)
        hold on;
        plot(learned_hh.mixture_comp{ii}, 'formatStr', 'm', 'LineWidth', 1.5);
        title_cells{3} = 'magenta = learned distributions. ';
    end
set(gca, 'FontSize', 12); % set the default font size for axes
end
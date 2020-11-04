%% 二维高斯函数作为特征分布的泊松RFS混合模型的演示
clear class;
construct_all_distributions();
clearvars;
close all;
%% initialisation
visualise_gaussian = [1 2 3]; % an array flag to visualise the Gaussian distributions
%% 1: ground-truth; 2: initialised model; 3: learned model
num_components = 3; %混合的组分
num_obs = 100; %观测的数量
dim_obs = 2; %维度
%% 形成混合比
true_hh.mixing_prop = mk_stochastic(rand([num_components, 1]));

%% mixture components
true_mu = cell(1, num_components);
true_cov = cell(1, num_components);
true_rate = cell(1, num_components); % for RFS

% cluster #1
true_mu{1} = [4/4; 4/4];
true_cov{1} = [.8 0; 0 .8];
true_rate{1} = 10;


% cluster #2
true_mu{2} = [1/4; 1/4];
true_cov{2} = [.5 0; 0 .5];
true_rate{2} = 5;

% cluster #3
true_mu{3} = [7/4; 1/4];
true_cov{3} = [.5 0; 0 .5];
true_rate{3} = 5;

for ii = 1:num_components
    true_hh.mixture_comp{ii} = GenericRFS(Poisson(true_rate{ii}), Gaussian(true_mu{ii}, true_cov{ii}));
end
%% 混合模型
true_mm = MixtureModel(true_hh); 
%% 采样并附标签
[all_obs, true_cluster_ids] = sample(true_mm, num_obs);

%% 打印出具体模型
fprintf('The ground-truth model:\n');
display(true_mm)


%% 学习模型
currkey = 0; % user's key press code
while currkey ~= 1
    %% initialise the mixture model
    dummy_hh.mixing_prop = ones(num_components, 1);
    for ii = 1:num_components
        dummy_hh.mixture_comp{ii} = GenericRFS(Poisson(1), Gaussian(zeros(dim_obs, 1), eye(dim_obs)));
        xx=dummy_hh.mixture_comp{ii};
    end
    init_mm = init_from_data(MixtureModel(dummy_hh), all_obs, true);
    
    %% learn MM
    learned_mm = em(init_mm, all_obs, 'threshold', 1E-5, 'maxNumIter', 50, 'verbose', 1);
    %% print details of the learned Mixture Model
    fprintf('The learned model:\n');
    display(learned_mm);
    
    %% visualise the Gaussian components
    init_hh = param(init_mm); 
    learned_hh = param(learned_mm);
    if ~isempty(visualise_gaussian)
        figure(10 + length(true_hh.mixture_comp)); 
        clf;
        
        title_cells = cell(1, 4);
        title_cells{4} = 'Gaussian components in the Mixture Models. ';
        for ii = 1:length(true_hh.mixture_comp)
            if sum(visualise_gaussian == 1)
                plot(true_hh.mixture_comp{ii}, 'LineWidth', 2); 
                hold on;
                title_cells{1} = 'blue = ground-truth. ';
            end
            if sum(visualise_gaussian == 2)
                plot(init_hh.mixture_comp{ii}, 'formatStr', 'k'); hold on;
                title_cells{2} = 'black = initialised distributions. ';
            end
            if sum(visualise_gaussian == 3)
                plot(learned_hh.mixture_comp{ii}, 'formatStr', 'm', 'LineWidth', 2); hold on;
                title_cells{3} = 'magenta = learned distributions. ';
            end
        end
        set(gca, 'FontSize', 16); % set the default font size for axes
        title({title_cells{4}, [title_cells{1}, title_cells{2}, title_cells{3}]}, 'FontSize', 20);
        xlabel('Press ESC to exit. Press any other key to learn the model again.', 'FontSize', 18);
        
        %% loop the learning process until the user presses 'q'
        pause;
        currkey = get(gcf, 'CurrentKey');
        if strcmp(currkey, 'escape')
            currkey = 1;
        end
    else
        currkey = 1;
    end
end

%% infer the cluster IDs
learned_cluster_ids = posterior(learned_mm, all_obs);

clc;clear;close;
load T14_brick1.mat;
T14 = keypoint;
T14_feat = [];
T14_card = [];
for i = 1:40
    T14_card = [T14_card size(T14{4,i},2)];
    T14_feat = [T14_feat T14{4,i}];
end
a = single(T14_feat');
T14_feat = double(a);
[T14_coeff,T14_score,T14_latent,T14_tsquared,T14_explained] = pca(T14_feat);
T14_explained
T14_feat_pca = T14_score(:,1:2);
save('T14.mat','T14','T14_card','T14_feat','T14_feat_pca');

load T15_brick2.mat;
T15 = keypoint;
T15_feat = [];
T15_card = [];
for i = 1:40
    T15_card = [T15_card size(T15{4,i},2)];
    T15_feat = [T15_feat T15{4,i}];
end
b = single(T15_feat');
T15_feat = double(b);
[T15_coeff,T15_score,T15_latent,T15_tsquared,T15_explained] = pca(T15_feat);
T15_explained
T15_feat_pca = T15_score(:,2:3);
save('T15.mat','T15','T15_card','T15_feat','T15_feat_pca');

load T20_upholstery;
T20 = keypoint;
T20_feat = [];
T20_card = [];
for i = 1:40
    T20_card = [T20_card size(T20{4,i},2)];
    T20_feat = [T20_feat T20{4,i}];
end
c = single(T20_feat');
T20_feat = double(c);
[T20_coeff,T20_score,T20_latent,T20_tsquared,T20_explained] = pca(T20_feat);
T20_explained
T20_feat_pca = T20_score(:,1:2);
save('T20.mat','T20','T20_card','T20_feat','T20_feat_pca');
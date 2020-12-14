clc;clear;close;
run('E:\VLFeat\vlfeat-0.9.21\toolbox\vl_setup.m')
vl_version verbose
%folder = 'E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T14_brick1';
folder = 'E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T20_upholstery';
%folder ='E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T15_brick2';
%folder  = 'F:\BaiduNetdiskDownload\包含UIUC纹理数据集\train\UIUC20_upholstery';
filepaths = dir(fullfile(folder,'*.jpg'));
num = length(filepaths);
keypoint = cell(4,num);
count = 0;
for i = 1:length(filepaths)
%     Iori = imread(fullfile(folder,filepaths(i).name));
%     keypoint{1,i} = Iori;
%     image(Iori)
%     grayI = rgb2gray(Iori);
%     I = single(grayI);
%     keypoint{2,i} = I;

    Iori = imread(fullfile(folder,filepaths(i).name));
    keypoint{1,i} = Iori;
    imshow(Iori)
    I = single(Iori);
    keypoint{2,i} = I;
    
    [f, d] = vl_sift(I,'Levels',3,'PeakThresh', 10);
    keypoint{3,i} = f;
    keypoint{4,i} = d;
    h = vl_plotframe(f);
    set(h,'color','r','linewidth',2);
    %colormap gray;
    clf;
    imshow(Iori)
    h = vl_plotframe(f);
    set(h,'color','g','linewidth',2) ;
    
    count = count + size(keypoint{3,i},2);
end
pois = count / length(filepaths)
% save('waffled.mat','keypoint');
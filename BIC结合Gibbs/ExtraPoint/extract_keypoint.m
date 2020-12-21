clc;clear;close;
run('E:\VLFeat\vlfeat-0.9.21\toolbox\vl_setup.m')
vl_version verbose
%folder = 'E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T14_brick1';         %点数最多 3 10
folder = 'E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T20_upholstery';    %容易出问题，基数属于中等 2 10
%folder ='E:\BaiduNetdiskDownload\uiuc-texture-gray-256x256-CASIAV3names\T15_brick2';         %点数最少 3 10
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
    %Iori = vl_impattern(fullfile(folder,filepaths(i).name));
    keypoint{1,i} = Iori;
    imshow(Iori);
    %image(Iori);
    pause(0.1);
    I = single(Iori);
    keypoint{2,i} = I;
    
    [f, d] = vl_sift(I,'Levels',2,'PeakThresh', 10);
    keypoint{3,i} = f;
    keypoint{4,i} = d;
    h = vl_plotframe(f);
    set(h,'color','g','linewidth',2);
    pause(0.05);
    %colormap gray;
    %     clf;
    %     imshow(Iori);
    %     pause(0.1);
    %     h = vl_plotsiftdescriptor(d,f) ;
    %     set(h,'color','g','linewidth',2) ;
    %     pause(0.1);
    
    count = count + size(keypoint{3,i},2);
end
pois = count / length(filepaths)
%save('T14_brick1.mat','keypoint');
save('T20_upholstery.mat','keypoint');
%save('T15_brick2.mat','keypoint');
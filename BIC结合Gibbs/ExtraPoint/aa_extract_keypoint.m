clc;clear;close;
run('E:\VLFeat\vlfeat-0.9.21\toolbox\vl_setup.m')
vl_version verbose
folder = 'F:\BaiduNetdiskDownload\纹理数据集\UIUC14_brick1';         %14点数最多3 10
% folder = 'F:\BaiduNetdiskDownload\纹理数据集\UIUC20_upholstery';     %20容易出问题，基数属于中等 2 10
%  folder ='F:\BaiduNetdiskDownload\纹理数据集\UIUC15_brick22';          %15点数最少3 10
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
    %     pause(0.1);
    I = single(rgb2gray(Iori));
    keypoint{2,i} = I;
    
    [f, d] = vl_sift(I,'Levels',2,'PeakThresh', 16);
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
save('T14c_brick1.mat','keypoint');
% save('T20c_upholstery.mat','keypoint');
% save('T15c_brick2.mat','keypoint');
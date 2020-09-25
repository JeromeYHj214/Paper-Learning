clc;clear;close;
run('E:\VLFeat\vlfeat-0.9.21\toolbox\vl_setup.m')
vl_version verbose
%  D:\dataset\DTD_dataset\dtd\images\scaly
folder = 'D:\dataset\DTD_dataset\dtd\images\waffled';
filepaths = dir(fullfile(folder,'*.jpg'));
num = length(filepaths);
keypoint = cell(4,num);
for i = 1:length(filepaths)
    Iori = imread(fullfile(folder,filepaths(i).name));
    keypoint{1,i} = Iori;
    %     image(Iori)
    I = single(rgb2gray(Iori));
    keypoint{2,i} = I;
    %     [f, d] = vl_sift(I,'Levels',3,'PeakThresh', 5);
    [f, d] = vl_sift(I,'PeakThresh', 5);
    keypoint{3,i} = f;
    keypoint{4,i} = d;
    %     h = vl_plotframe(f);
    %     set(h,'color','r','linewidth',2);
    %     colormap gray;
    %     clf;image(I)
    %     h = vl_plotframe(f);
    %     set(h,'color','g','linewidth',2) ;
    i
end
save('waffled.mat','keypoint');
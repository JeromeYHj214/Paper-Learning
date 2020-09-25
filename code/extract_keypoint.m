img1ori = imread('Snowball.jpg');
img1 = double(rgb2gray(img1ori));  %single����ת���ɵ����ȵģ�֮ǰ�϶���double����Ϥһ���
                                   %��Ϊ�����vl_sift��������Ҫ�õ������ȻҶ�ͼ��
%ͼƬ2Ҫʶ����ڵ�����             
img2ori = imread('Snowball.jpg');
img2 = double(rgb2gray(img2ori));
 
%% ��ȡSIFT������ƥ��������
[f1, d1] = vl_sift(img1,'Levels',5,'PeakThresh', 4); 
[f2, d2] = vl_sift(img2,'Levels',5,'PeakThresh', 5);  
%f1Ϊ���ɵ���Ԫ��[x,y,s,th],�ֱ����������x��y���꣬sΪ���ȿռ��С��thָ����������
%d1�����������ӣ�Ҳ�����Ǹ�128ά������
[matches, scores] = vl_ubcmatch(d1, d2);
[dump,scoreind]=sort(scores,'ascend');
 
 
%% �������ͼƬ
newfig=zeros(size(img1,1), size(img1,2)+size(img2,2),3);  %�¹���һ��3ά���飬��ΪͼƬ1��
                                                         %��������ΪͼƬ1��ͼƬ2��������
newfig(:,1:size(img1,2),:) = img1ori;
newfig(1:size(img2,1) ,(size(img1,2)+1):end,:)=img2ori;
newfig=uint8(newfig);
figure;
image(newfig);   % �������ͼƬ
axis image
% colormap(gray)
 
%% ����ƥ��������
figure;
image(newfig); % �������ͼƬ+ƥ����ڵ�������
axis image
f2Moved=f2;  %��Ϊ��ʱͼ����x��������ƽ�Ƶģ���Ҫƽ�ƵĴ�СΪͼ1������
m=size(img1,2)
f2Moved(1,:) = f2Moved(1,:)+size(img1,2);
h1 = vl_plotframe(f1);  %��֮ǰ����Ԫ���������Ƭ�Ͻ��л滭
h2 = vl_plotframe(f2Moved);
set(h1,'color','g','linewidth',2) ;
set(h2,'color','r','linewidth',2);
hold on
% ����scoresǰ10%
plotRatio=0.1;
for i= 1:fix(plotRatio*size(matches,2))  %fix��ȡ������������������ҵ���ƥ���ǰ10%
    idx = scoreind(i);
    line([f1(1,matches(1,idx)) f2Moved(1,matches(2,idx))],...
    [f1(2,matches(1,idx)) f2Moved(2,matches(2,idx))], 'linewidth',1, 'color','b')
end
hold off
%���������е�...����Ϊmatlabһ��װ���£������������ӷ�
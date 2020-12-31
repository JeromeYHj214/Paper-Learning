mu1 = [9 5;9 15;6 12];
sigma1 = cat(3,[1 0; 0 1],[2 0.5; 0.5 2],[2 0.5; 0.5 2]);
p1 = ones(1,3)/3;
gm1 = gmdistribution(mu1,sigma1,p1);
[x1,x2] = meshgrid(0:0.2:15,0:0.2:20);
contour(x1,x2,reshape(pdf(gm1,[x1(:) x2(:)]),size(x1,1),size(x1,2)),'r');
hold on;

mu2 = [5 5;5 15;9 9];
sigma2 = cat(3,[1 0; 0 1],[2 -0.5; -0.5 2],[2 0.5; 0.5 2]);
p2 = ones(1,3)/3;
gm2 = gmdistribution(mu2,sigma2,p2);
contour(x1,x2,reshape(pdf(gm2,[x1(:) x2(:)]),size(x1,1),size(x1,2)),'g');
hold on;

mu3 = [4 5;6 16;8 8];
sigma3 = cat(3,[1 0; 0 1],[2 -0.5; -0.5 2],[2 0.5; 0.5 2]);
p3 = ones(1,3)/3;
gm3 = gmdistribution(mu3,sigma3,p3);
contour(x1,x2,reshape(pdf(gm3,[x1(:) x2(:)]),size(x1,1),size(x1,2)),'b');
hold on;
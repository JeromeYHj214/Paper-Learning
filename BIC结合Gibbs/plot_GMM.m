mu = [-4 -4;-4 -4;6 6;6 6;5 -6];
sigma = cat(3,[1 0.5; 0.5 1],[6 -2; -2 6],[1 0.5; 0.5 1],[6  -2; -2 6],[1 0; 0 1]);
p = ones(1,5)/5;
gm = gmdistribution(mu,sigma,p);
[x1,x2] = meshgrid(-15:0.2:15,-15:0.2:15);
contour(x1,x2,reshape(pdf(gm,[x1(:) x2(:)]),size(x1,1),size(x1,2)),'r');
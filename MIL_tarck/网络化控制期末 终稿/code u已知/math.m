u1 = [-1; 0];
u2 = [1; 0];
cov1 = [1, 1/2;
        1/2, 1];
cov2 = [1. -1/2;
        -1/2, 1];
cov11 = inv(cov1)
cov22 = inv(cov2)
a1 = cov11*u1 - cov22*u2
a2 = a1'
a3 = cov11 - cov22
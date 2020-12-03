load ex2_X1.mat;
he = 0;
for i = 1:100
    he = he + X1{1,i};
end
mean = he/100
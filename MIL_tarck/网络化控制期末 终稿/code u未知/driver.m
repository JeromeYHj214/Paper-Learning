function [ S ] = driver( M, N )
[A, B] = max(M);
Q = [A, B];
X = Q(2);
if X == 1
    S = N(:,X);
elseif X == 2
    S = N(:,X);
elseif X == 3
    S = N(:,X);
end




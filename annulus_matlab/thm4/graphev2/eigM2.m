function E = eigM2(a,b,n)
h = (b-a)/n;
M = h/2*(Amatrix2(a,b,n)-Bmatrix2(a,b,n));
E = eig(M);
E = E(1);

%% eigenvector
global V D
[V,D] = eig(M);
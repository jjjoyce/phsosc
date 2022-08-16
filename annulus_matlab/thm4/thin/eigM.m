function E = eigM(a,b,n)
h = (b-a)/n;
M = h/2*(Amatrix(a,b,n)-Bmatrix(a,b,n));
E = eig(M);
E = E(1);

%% eigenvector
global V D
[V,D] = eig(M);
function M = Bmatrix(a,b,n)
x = linspace(a,b,n+1);
for i = 1:n+1
    for j = 1:n+1
        if (j>=2)||(j<=n) 
            M(i,j) = 2*cb(x(i),x(j));
        else
            M(i,j) = cb(x(i),x(j));
        end;
    end;
end;
v = linspace(1,1,n+1);
M = diag(M*v');
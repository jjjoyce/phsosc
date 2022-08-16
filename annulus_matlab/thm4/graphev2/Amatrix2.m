function M = Amatrix2(a,b,n)
global rho
x = linspace(a,b,n+1);
for i = 1:n+1
    for j = 1:n+1
        if (j>=2)||(j<=n) 
            M(i,j) = 2*(ca(x(i),x(j))+2*rho*ca2(x(i),x(j)));
        else
            M(i,j) = ca(x(i),x(j)+2.*rho.*ca2(x(i),x(j)));
        end;
    end;
end;
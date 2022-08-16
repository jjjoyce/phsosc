a = 2
b = 10
N = 100;
h = (b-a)/N;
r = a:h:b;
s = linspace(1,1,101);
s(1) = 1/2;
s(101) = 1/2;
rs = r.*s;

fav = rs*(ker(a,r,1)-ker(a,r,0))';
for i = 2:N+1
    A(i-1,i-1) = rs(i)*(ker(r(i),r(i),1)-ker(a,r(i),1)) - rs*ker(r(i),r,1)';
    frv = rs*(ker(r(i),r,1)-ker(r(i),r,0))';
    B(i-1) = fav-frv;
    for j = 2:N+1
        if i ~= j
            A(i-1,j-1) = rs(j)*(ker(r(i),r(j),1)-ker(a,r(j),1));
        end;
    end;
end;

g = A\B';
plot(r,[0;g])


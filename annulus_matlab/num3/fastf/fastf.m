%a = 1
%b = 10
%ff = fastf(a,b) f[1..101]

function ff = fastf(a,b)
N = 100;
h = (b-a)/N;
r = a:h:b;
r1 = r(2:101);
s = linspace(1,1,101);
s(1) = 1/2;
s(101) = 1/2;
rs = r.*s;
rs1 = rs(2:N+1);
A =rs1.*(ker(r1',r1,1)-ker(a',r1,1))-diag(rs*(ker(r1',r,1))');
fav = rs*(ker(a,r,1)-ker(a,r,0))';
frv = rs*(ker(r1',r,1)-ker(r1',r,0))';
B = fav - frv;
g = A\B';
plot(r,[0;g])
ff = [0;g];
function f = cgp(r,a)
gamma0 = ca(a,a)-cb(a,a);
fu = cap(r,a).*(gamma0+cb(r,a)) - ca(r,a).*cbp(r,a);
fd = (gamma0+cb(r,a)).^2;
f = fu./fd;


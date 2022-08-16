function g0=g0(a)
y=2.*a.^2;
g0 = pi.*a.*...
(besseli(0,y,1)-2.*besseli(1,y,1)+besseli(2,y,1));
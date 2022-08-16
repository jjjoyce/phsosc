function g = hpker(r,s)
%a = 0.879000000000000;
g1 = (-2*s).*ker(r,s,2) +r.*(ker(r,s,1)+ker(r,s,3));
g2 = (-2*s).*ker(r,s,0) + 2*r.*ker(r,s,1);
g = 0.5*(g1+g2);
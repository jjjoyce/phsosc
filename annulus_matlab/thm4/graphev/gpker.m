function g = gpker(r,s)
%a = 0.879000000000000;
g = (-2*s).*ker(r,s,1) + r.*(ker(r,s,0)+ker(r,s,2));

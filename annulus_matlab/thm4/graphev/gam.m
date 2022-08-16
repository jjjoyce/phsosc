function g = gam(a)

g = a.*(0.5*(ker(a,a,2)+ker(a,a,0)) - ker(a,a,1));


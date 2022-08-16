function f = cap(r,s)
% s = a
a = s;
f = 1/2*(ker(r,a,2)+ker(r,a,0))+a/2.*hpker(r,a);
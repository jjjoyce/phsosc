function f = cbp(r,s)
% s = a
a = s;
f = ker(r,a,1)+a.*gpker(r,a);
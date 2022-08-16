function ff = fv(s)
global fcf alpha a b 
f = alpha.*fcf';
N=100;
h = (b-a)/N;
ind  = round((s-a)./h)+1;
ff = f(ind);
end
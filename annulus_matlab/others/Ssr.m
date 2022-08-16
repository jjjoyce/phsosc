function S = Ssr(s,r)
%S(s,r) = sin(f(s) - f(r) + alpha)
global alpha
S = sin(fv(s)-fv(r)+alpha);
end
function C = Csr(s,r)
%C(s,r) = cin(f(s) - f(r) + alpha)
global alpha

C = cos(fv(s)-fv(r)+alpha);
end
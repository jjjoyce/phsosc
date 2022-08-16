function M = Msr( s,r )
% M(s,r) = s[C*kplus+i*S*kminus]

M = s*(Csr(s,r)*kmp(s,r)+j*Ssr(s,r)*kmm(s,r));
end


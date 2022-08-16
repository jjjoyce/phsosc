function kmp = kmp( s,r )
%k_m_plus

m = 1;

kmp = 0.5*(ker(s,r,m+1)+ker(s,r,m-1));
end


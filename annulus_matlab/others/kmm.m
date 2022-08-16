function kmm = kmm( s,r)
%k_m_minus

m = 1;

kmm = 0.5*(ker(s,r,m+1)-ker(s,r,m-1));

end


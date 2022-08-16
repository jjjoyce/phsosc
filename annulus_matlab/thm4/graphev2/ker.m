function ker = ker(r,s,n)
ker = 2*pi.*exp(-(r.^2+s.^2)).*besseli(n,2.*r.*s);
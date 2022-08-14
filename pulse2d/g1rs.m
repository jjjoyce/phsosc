function g1rs = g1rs( r, s)
%G1 Summary of this function goes here
%Detailed explanation goes here
%g1rs = s.*exp(-(r.^2+s.^2)).*besseli(1,2*r*s);
%%g1rs = s.*exp(-(r-s).^2).*exp(-2*r*s).*besseli(1,2*r*s);
g1rs = s.*exp(-(r-s).^2).*besseli(1,2*r*s,1);
end


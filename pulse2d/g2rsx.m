function g2rsx = g2rsx( r, s,x )
%   Detailed explanation goes here
g2rsx =  s.*exp(-(r-s).^2).*cos(x).*exp(2.*r.*s.*(cos(x)-1)).*u1(r,x);
end


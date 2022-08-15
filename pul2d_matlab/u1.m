function u1 = u1( r,t )
%   u1(r,theta) using delta(u)=-sin(u)
%   Detailed explanation goes here
[a b] = getRadius;
u1=(sqrt(pi)*(erf(a-r)-erf(b-r)+(exp(-(r.^2.*sin(t).*sin(t))).*(-erf(a-r.*cos(t))+erf(b-r.*cos(t))))))./(4*r);
end


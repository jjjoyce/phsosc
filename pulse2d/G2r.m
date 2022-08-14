function G2r = G2r( r )
%GR Summary of this function goes here
%   Detailed explanation goes here
[a b]=getRadius;
gsx = @(s,x) g2rsx(r,s,x);                     
G2r =(1/(2*pi))*integral2(gsx,a,b,0,2*pi);
end


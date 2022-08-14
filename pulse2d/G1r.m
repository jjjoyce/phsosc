function G1r = G1r( r)
%G1 Summary of this function goes here
%   Detailed explanation goes here
[a b] = getRadius;
G1r = integral(@(s) g1rs(r,s),a,b);
end


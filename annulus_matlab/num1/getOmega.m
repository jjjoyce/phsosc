function Omega = getOmega(alpha,a,b,f)

N = size(f,2)-1;
h = (b-a)/N;
r = a:h:b;
g = 2*pi*exp(-(r.^2+a^2)).*besseli(1,2.*r.*a).*sin(-f+alpha)-...
    2*pi*exp(-(r.^2+a^2)).*besseli(0,2.*r.*a).*sin(alpha);
g = r.*g+1;   
s = linspace(1,1,N+1);
    s(1) = 1/2; s(N+1) = 1/2;
Omega = h*s*g'+1;


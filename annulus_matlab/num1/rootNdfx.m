function F = rootNdfx(f)
global x
N = size(f,2);
[alpha a b] = getVariable;

h = (b-a)/N;
r = a:h:b;

N = N+1;


for i = 2:N %r
    g(1) = (a/x^2)*...
            (  (2*pi*exp(-((r(i))^2+a^2)/(x^2))*besseli(1,2*r(i)*a/(x^2))*sin(-f(i-1)+alpha)-...
            (2*pi*exp(-(a^2+a^2)/(x^2))*besseli(1,2*a*a/(x^2))*sin(alpha)))  -...
            (2*pi*exp(-((r(i))^2+a^2)/(x^2))*besseli(0,2*r(i)*a/(x^2))-...
            (2*pi*exp(-(a^2+a^2)/(x^2))*besseli(0,2*a*a/(x^2))))*sin(alpha));
    for j = 2:N  %r'
        g(j) = (r(j)/x^2)*...
            ( (2*pi*exp(-((r(i))^2+(r(j))^2)/(x^2))*besseli(1,2*r(i)*r(j)/(x^2))*sin(-f(i-1)+f(j-1)+alpha)-...
            (2*pi*exp(-(a^2+(r(j))^2)/(x^2))*besseli(1,2*a*r(j)/(x^2))*sin(f(j-1)+alpha)))-...
            (2*pi*exp(-((r(i))^2+(r(j))^2)/(x^2))*besseli(0,2*r(i)*r(j)/(x^2))-...
            (2*pi*exp(-(a^2+(r(j))^2)/(x^2))*besseli(0,2*a*r(j)/(x^2))))*sin(alpha));
    end;
    s = linspace(1,1,N);
    s(1) = 1/2; s(N) = 1/2;
    F(i-1) = h*s*g';
end;

function F = rootNdf(f)

N = size(f,2);
[alpha a b] = getVariable;

h = (b-a)/N;

r = a:h:b;

N = N+1;

for i = 2:N %r
    g(1) = a*...
            (  (2*pi*exp(-((r(i))^2+a^2))*besseli(1,2*r(i)*a)*sin(-f(i-1)+alpha)-...
            (2*pi*exp(-(a^2+a^2))*besseli(1,2*a*a)*sin(alpha)))  -...
            (2*pi*exp(-((r(i))^2+a^2))*besseli(0,2*r(i)*a)-...
            (2*pi*exp(-(a^2+a^2))*besseli(0,2*a*a)))*sin(alpha));
    for j = 2:N  %r'
        g(j) = r(j)*...
            ( (2*pi*exp(-((r(i))^2+(r(j))^2))*besseli(1,2*r(i)*r(j))*sin(-f(i-1)+f(j-1)+alpha)-...
            (2*pi*exp(-(a^2+(r(j))^2))*besseli(1,2*a*r(j))*sin(f(j-1)+alpha)))-...
            (2*pi*exp(-((r(i))^2+(r(j))^2))*besseli(0,2*r(i)*r(j))-...
            (2*pi*exp(-(a^2+(r(j))^2))*besseli(0,2*a*r(j))))*sin(alpha));
    end;
    s = linspace(1,1,N);
    s(1) = 1/2; s(N) = 1/2;
    F(i-1) = h*s*g';
end;

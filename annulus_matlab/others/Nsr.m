function Nn = Nsr( r )
% N(r) = int_a^b s*C*k1 ds

N = 100;

global a b 

h = (b-a)/N;
s = a:h:b;
%%  ker1
g =s.*Csr(s,r).*ker(s,r,1);
w = linspace(1,1,N+1);
w(1) = 1/2; w(N+1) =1/2;
Nn =h*w*g';
end


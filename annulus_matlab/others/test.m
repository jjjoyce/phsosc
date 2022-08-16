function ev = test(alpha1,a1,b1)
addpath(genpath('/Users/yujie/Documents/MATLAB/rrrrr/xxl/part1/num3/fastf'))

global a b alpha fcf
a = a1;
b = b1;
alpha = alpha1;

N = 100;
i = 1;


  
        h = (b-a)/N;
        r = a:h:b;
        fcf = fastf(a,b);

        A = 0;
        Nv = linspace(0,0,101);
        Mv = zeros(101,101);
        for  k = 1:1:N+1
             Nv(k) = Nsr(r(k));
             for j = 1:1:N+1
                Mv(k,j) = Msr(r(j),r(k));
             end
        end
 
    A = h*Mv - diag(Nv); 
    [V,D] = eig(A);
    E = eig(A);
    ev = real(E(1));
    %[a b real(E(1))]


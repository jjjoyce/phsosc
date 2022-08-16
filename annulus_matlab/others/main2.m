addpath(genpath('/Users/yujie/Documents/MATLAB/rrrrr/xxl/part1/num3/fastf'))

global a b alpha fcf

N = 100;

i = 1;
alpha = 0.125;

for a = 0.43 : 0.01 : 0.88
    b = a;
   while b<10.01
   %while b>0
        b = b + 0.01;
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
    
    %[a b real(E(1))]
    
    if E<0 
       i = i+1;
       break  
    else if a ~= b
       spv(i,:) = [a b real(E(1))];
        end 
    end  
   end
end


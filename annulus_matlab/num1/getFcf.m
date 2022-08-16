function fcf = getFcf(N)
% Solution of the model on an annulus is in the form
% u(r, ?, t) = ?t + ? + f (r)

% Divide [a,b] into N intervals 

[alpha a b] = getVariable;

h = (b-a)/N; 
r = a:h:b;
f = linspace(0,0,N);
f0 = f;


%func = @rootNdf;
func = @rootNdf
f = fsolve(func,f0);

%% Figure of f(r)
%figure
%plot(r,[0 f]);

fcf = [0 f];
%Omega = getOmega(alpha,a,b,[0 f]);

%% Sample-f.mat is a solution when a=1, b=10, alpha=1 , and N=100


end


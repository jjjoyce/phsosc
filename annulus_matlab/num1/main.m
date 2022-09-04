% divide [a,b] into N parts
%% define a,b,al in command window first if not using loopal
% a=2;b=10;

global al 
al = 0;

global N

N = 100; 

fcf = getFcf(N);

[alpha a b] = getVariable;
r = linspace(a,b,N+1);

% plot(r,fcf,'b');

% plott works only N = 100
% plott(fcf);

% Om = getOmega(alpha,a,b,fcf);
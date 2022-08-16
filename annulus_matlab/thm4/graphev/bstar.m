
a = 0.57:0.01:0.87;
ga0 = ca(a,a)-cb(a,a);
ga1 = gamma1(a);

figure;
bss = a - ga0./ga1;
plot(a,bss,'r')

load('bstar0.mat');
hold on
plot(as,bs)
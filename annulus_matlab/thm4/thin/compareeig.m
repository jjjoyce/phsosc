delta = 0.01;
a = 0:0.01:1;
ga0 = g0(a);
ga1 = g1(a);

ev = (ga0 + delta*ga1)*delta;

figure('Name','gamma0 vs a')
plot(a,ga0,'m');
hold on;

% x-axi
c = linspace(0,0,size(a,2));
plot(a,c,'c');


figure('Name','gamma1 vs a')
plot(a,ga1,'m');
hold on;

% x-axi
c = linspace(0,0,size(a,2));
plot(a,c,'c');


figure('Name','gamma0, gamma1, and the sum')
plot(a,ev,'b');
hold on;

plot(a,ga0,'r')
hold on;

plot(a,ga1,'c');
hold on;

% x-axi
c = linspace(0,0,size(a,2));
plot(a,c,'bl');
hold on;

legend('ev','ga0','ga1','zero');

figure('Name','compare eigenvalue')
for i = 1:101
    x = 0.01*(i-1);
    eigv(i) = eigM(x,x+delta,100);
end;
plot(a,eigv);

hold on

plot(a,ev,'*')

legend('eig','g0+delta*g1')

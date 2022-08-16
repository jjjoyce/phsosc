delta = 1;
a = 0:0.01:1;
ga0 = ca(a,a)-cb(a,a);
ga1 = gamma1(a);
ev = (ga0 + delta*ga1)*delta;

figure('Name','gamma0 vs a')
%gamma vs a when alpha = 0
%gam(a) is the same as ga0
plot(a,gam(a),'m');
hold on;

% x-axi
c = linspace(0,0,size(a,2));
plot(a,c,'c');


figure('Name','gamma0, gamma1, and the sum')
plot(a,ev,'b');
hold on;

plot(a,ga0,'r')
hold on;

plot(a,ga1,'y');
hold on;

legend('ev','ga0','ga1');

% x-axi
c = linspace(0,0,size(a,2));
plot(a,c,'bl');
hold on;

figure('Name','compare eigenvalue')
for i = 1:101
    x = 0.01*(i-1);
    eigv(i) = eigM(x,x+delta,100);
end;
plot(a,eigv);

hold on

plot(a,ev,'*')

legend('eig','ga0+delta*ga1')

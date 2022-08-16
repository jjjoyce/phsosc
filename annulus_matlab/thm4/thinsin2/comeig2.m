delta = 0.1;
a = 0:0.01:1;
ga01 = g01(a);
ga11 = g11(a);

global rho
rho=-0.25

ev1 = (ga01 + delta*ga11)*delta;

figure('Name','gamma01 vs a')
plot(a,ga01,'m');
hold on;

% x-axi
c = linspace(0,0,size(a,2));
plot(a,c,'c');


figure('Name','gamma11 vs a')
plot(a,ga11,'m');
hold on;

% x-axi
c = linspace(0,0,size(a,2));
plot(a,c,'c');


figure('Name','gamma01, gamma11, and the sum')
plot(a,ev1,'b');
hold on;

plot(a,ga01,'r')
hold on;

plot(a,ga11,'c');
hold on;

% x-axi
c = linspace(0,0,size(a,2));
plot(a,c,'bl');
hold on;

legend('ev1','ga01','ga11','zero');

figure('Name','compare eigenvalue')
for i = 1:101
    x = 0.01*(i-1);
    eigv1(i) = eigM2(x,x+delta,100);
end;
plot(a,eigv1);

hold on

plot(a,ev1,'*')

legend('eig','g01+delta*g11')

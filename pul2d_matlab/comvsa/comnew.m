%load('datamatato4b10.mat');
load('datamatato4b5.mat');
%dat=importdata('amp0.1a0.1to4b10z0.dat');
dat=importdata('amp0.1a0.1to4b5z0.dat');

dat_p=dat(:,2);
dat_fb=dat(:,43);
amp=0.1;
fx=dat_fb;
fm=amp*fb;
figure('Name','compare f(b)')
plot(ax,fx,'LineWidth',1.5)
hold on
 plot(ax,fm,'-.','LineWidth',1.5)
legend({'Approximation','Simulation'},'FontSize',18)
ylabel('f(b)','FontSize',22)
xlabel('a','FontSize',22);

figure('Name','compare omega')
%plot(ax,(1-dat_p)/(amp^2));
%plot(ax,dat_p);
plot(ax,dat_p,'-.','LineWidth',1.5);
hold on
%plot(ax,1+amp^2*p)
plot(ax,1-amp^2*p,'LineWidth',1.5)
legend({'Approximation','Simulation'},'FontSize',18)
ylabel({'$\Omega$'},'Interpreter','latex','FontSize',22)
xlabel('a','FontSize',22)

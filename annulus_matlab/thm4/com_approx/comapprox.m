%% Compare eigenvalue using different approximation
load('bstar0.mat', 'bs');
a=linspace(0,1,100);
figure;
plot(a,bs,'*');

% pertubation
% x=1.54513;
b1=1.54513./(2*a);
hold on
plot(a,b1)

% Gershgorin 
ahat=sqrt(1.54513/2);
plot([ahat ahat],[ahat 10])


% improved Gershgorin
dat=importdata('minavsb.dat');
ma=dat(:,2);
mb=dat(:,1);
plot(ma,mb,'+')

ylim([0 10]);
xlabel('a')
ylabel('b^*')
legend('Numerical','Pertubation','Gershgorin','improved Gershgorin ')
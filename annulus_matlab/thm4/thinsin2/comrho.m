%% bstar vs a numerical 

% rho=0
load('bstar0.mat')
bs0=bs;
% rho=0.25
load('bstar025.mat')
bsp=bs;
% rho=-0.25
load('bstarn025.mat')
bsn=bs;

ax=linspace(0,1,100);
figure;
plot(ax,bs0);
hold on
plot(ax,bsp);
plot(ax,bsn);

xlabel('a');
ylabel('b^*');
legend('rho=0','rho=0.25','rho=-0.25');

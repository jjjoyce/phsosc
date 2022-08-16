%% plot

a=0.2;
b=5;
d=0.4;
amp=1;

m=50;
N=2*m+1;
dx=b/m;
q=(-b):dx:b;

%load('v_pul2da'+string(a)+'b'+string(b)+'d'+string(d)+'amp'+string(amp)+'.mat')

load('vv_pul2da'+string(a)+'b'+string(b)+'d'+string(d)+'amp'+string(amp)+'.mat')



figure
h=pcolor(q,q,V);
colormap('hsv');
set(h,'EdgeColor','none');
colorbar

f=mod(V(m,m+1:N)+pi,2*pi)-pi;
%f=f-f(1)
figure
plot(f)
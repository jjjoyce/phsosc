%% plot

a=0.5;
b=5;
d=0;
amp=1;

m=50;
N=2*m+1;
dx=b/m;
q=(-b):dx:b;

%load('v_pul2da'+string(a)+'b'+string(b)+'d'+string(d)+'amp'+string(amp)+'.mat')

%load('v_pul2da'+string(a)+'b'+string(b)+'d'+string(d)+'amp'+string(amp)+'.mat')

for i = 1:1:100
    for j = 1:1:100
        x = (i-50)./50*b;
        y = (j-50)./50*b;
        r = sqrt(x^2+y^2);
        if (r<a)||(r>b) V(i,j)=NaN;
        end;
    end;
end;

figure
h=pcolor(q,q,V);
colormap('hsv');
set(h,'EdgeColor','none');

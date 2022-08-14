%% plot the annulus when N=40
%% a=1;b=5;
N=40;
alpha=0;
% [a b] = getRadius;
a = 1;
b = 10;
amp=1;
name =  ['annp' 'amp' num2str(amp) 'a' num2str(a) 'b' num2str(b) 'z' num2str(alpha) '.dat'];
%% from annulus40.ode
data=importdata(name);
%data=importdata('tt.dat');
f = data(1,3:43);
v =  data(:,44:84);
m = zeros(100,100);
p = data(1,2);
for i = 1:1:100
    for j = 1:1:100
        x = (i-50)./50*b;
        y = (j-50)./50*b;
        xi = atan2(y,x);
        r = sqrt(x^2+y^2);
        rj=getIndexn(r,a,b,40);
        vj=v(:,rj);
        zj=getIndexn((mod(xi-f(rj)+2*pi,2*pi)),0,2*pi,100);
        m(i,j) = vj(zj);
        if (r<a)||(r>b) m(i,j)=NaN;
        end;
    end;
end;

figure;

h = pcolor(m);
colormap('hsv');
set(h, 'EdgeColor', 'none');

xticks(linspace(1,100,11));
axi = [linspace(-b,b,11)];
xticklabels(axi)
yticks(linspace(1,100,11));
yticklabels(axi)


omega2=(1-p)/(amp^2)
fx=f;
% uncomment to compare fm and fx
% comparef(fx,fm,amp);
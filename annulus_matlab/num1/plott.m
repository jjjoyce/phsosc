%% plot the annulus when N=100
function plott(fcf)
[alpha a b] = getVariable;
fm = fcf;
m = zeros(200,200);
for i = 1:1:200
    for j = 1:1:200
        x = (i-100)./100*10;
        y = (j-100)./100*10;
        xi = atan2(y,x);
        r = sqrt(x^2+y^2);
        %m(i,j) = mod(xi-0.25*r+2*pi,2*pi);
        m(i,j) = mod(xi-fm(getIndex(r))+2*pi,2*pi);
        if (r<a)||(r>b) m(i,j)=NaN;
        end;
    end;
end;
h = pcolor(m);
set(h, 'EdgeColor', 'none');
colormap('hsv');

xticks(linspace(1,200,11));
xticklabels([-10 -8 -6 -4 -2 0 2 4 6 8 10])
%xticklabels({'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi'})
yticks(linspace(1,200,11));
yticklabels([-10 -8 -6 -4 -2 0 2 4 6 8 10])
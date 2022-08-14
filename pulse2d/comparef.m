function comparef = comparef(fx,fm,amp )
% Compare f from xpp and matlab
[a b] = getRadius;

l = size(fx);
l = l(2);
figure;
ax = linspace(a,b,l);
plot(ax,fx,'*');
hold on;
fm = amp*fm;
l = size(fm);
l = l(1);
ax = linspace(a,b,l);
plot(ax,fm);
legend('xpp','matlab')
end

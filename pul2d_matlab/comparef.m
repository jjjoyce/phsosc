%% only compare wat weak coupling 
% get fm from main_matrix
% get fx from pul2dannxpp.m

[a b] = getRadius;
amp = 0.1;

l = size(fx);
l = l(2);
ax = linspace(a,b,l);
figure('Name','compare f(r)')
plot(ax,fx,'+','LineWidth',1.5);
hold on
l = size(fm);
l = l(1);
ax = linspace(a,b,l);
plot(ax,amp*fm,'LineWidth',1.5)
legend({'Simulation','Approximation'},'FontSize',18)

ylabel({'f(r)'},'FontSize',22)
xlabel('r','FontSize',22)
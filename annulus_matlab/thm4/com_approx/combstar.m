%% Compare eigenvalue using pertubation

load('bstar0.mat', 'bs');
a=linspace(0,1,100);
b=bs;

%x=1.54513;
b1=1.54513./(2*a);

figure;
plot(a,b,'*');
hold on
plot(a,b1)

legend('Numerical','Analysis')
xlabel('a')
ylabel('b')

b2=log(1.54513/2)-log(a);
figure;
plot(log(a),log(b),'*');
hold on
plot(log(a),b2)

legend('Numerical','Analysis')
xlabel('log(a)')
ylabel('log(b*)')
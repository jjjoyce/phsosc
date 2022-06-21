clear all

close all

%% parameters
T=20000 
m=50;
N=2*m+1;
N2=N*N;
a=0.2;
a2=a*a;
b=10;

b2=b*b;
d=0;
dt=0.05
dx=b/m;
%sig=.25; %Gaussian kernel
sig = 1;
q=(-b):dx:b;
alpha=0.5;
beta=100;

R2 = zeros(N,N); % check the circle
U=zeros(N,N);  %phase
M=nan(N,N);   %mask
Up=U;
Q=zeros(N2,1); % Del(U)=alpha*(sind-sin(u+d))
P=zeros(N2,1);  % P(U)=exp(beta*cos(U))/(2Pi*I0)

Nb = 2*pi*besseli(0,beta);

D=zeros(N2,N2);  % kernel W

%%
filename = 'ttpul2da'+string(a)+'b'+string(b)+'d'+string(d)+'amp'+string(alpha)+'.gif'; 

%% compute distance matrix
for i=1:N
  x=q(i);
  for j=1:N
  y=q(j);
  r=x*x+y*y;
  k=(j-1)*N+i;
    for ip=1:N
        xp=q(ip);
	for jp=1:N
	  kp=(jp-1)*N+ip;
	  yp=q(jp);
          rp=xp*xp+yp*yp;
	   if(((r>=a2)&(r<=b2)&(rp>=a2)&(rp<=b2)))
	      z=(x-xp)^2+(y-yp)^2;
              D(k,kp)=exp(-z/(sig*sig))*dx*dx;
	   end
	end
     end
  end
end

%% initialize U and mask M
for i=1:N
  for j=1:N
    r=q(i)^2+q(j)^2;
    if ((r>=a2)&(r<=b2))
      U(i,j)=mod(atan2(q(j),q(i))+2*pi+rand()*.2,2*pi);
      %U(i,j)=2*pi*rand();
      M(i,j)=1;
    end
  end
end
U0=U;

figure(1);
h0=pcolor(q,q,mod(U,2*pi).*M);
colormap('hsv')
set(h0,'EdgeColor','none');
drawnow;
hold on;
frame = getframe(1);
im = frame2im(frame);
[ani,map] = rgb2ind(im,256);
imwrite(ani,map,filename,'gif','LoopCount',Inf,'DelayTime',0.2);


%% ode
for t=1:T
   Q=alpha*(sin(d)-sin(d+U(:)));
   P=(1/Nb)*exp(beta*cos(U(:)));
   WP=D*P;
   Up(:)=1+Q.*WP;
   U(:)=U(:)+dt*Up(:);
   if mod(t,500) == 0 %change delaytime when change mod
        h0=pcolor(q,q,mod(U,2*pi).*M);
        colormap('hsv')
        set(h0,'EdgeColor','none');
        drawnow;
        hold on;
        frame = getframe(1);
        im = frame2im(frame);
        [ani,map] = rgb2ind(im,256);
        imwrite(ani,map,filename,'gif','WriteMode','append','DelayTime',0.2);
   end    
end   

%%plot
norm(Up)
V=nan(N,N);
V0=V;
i0=m;
j0=m+floor(m/2);
for i=1:N
  for j=1:N
    r=q(i)^2+q(j)^2;
    if ((r>=a2)&(r<=b2))
    V(i,j)=mod(U(i,j)-U(i0,j0),2*pi);
    V0(i,j)=mod(U0(i,j)-U0(i0,j0),2*pi);
    end
  end
end

figure %% initial state
h0=pcolor(q,q,V0);
colormap('hsv')
set(h0,'EdgeColor','none');

figure
h=pcolor(q,q,V);
colormap('hsv');
set(h,'EdgeColor','none');

save('ttv_pul2da'+string(a)+'b'+string(b)+'d'+string(d)+'amp'+string(alpha)+'.mat','V')

%% calculate f(r)
f=mod(V(m,m+1:N)+pi,2*pi)-pi;
figure
plot(f)

    

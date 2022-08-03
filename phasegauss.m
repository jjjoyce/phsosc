% phase coupled oscillators through guassian kernel
% size of the rectangular grid is N*N
% wave solution u = theta + f(r)
% w(r) = exp(-r^2) 
% h(u) = sin(u+d)-sin(d)

clear all

close all
m=50;  
N=2*m+1;
N2=N*N;

a=1; % inner radius
a2=a*a;
b=8; % outer radius
b2=b*b;

d=0.4;
dt=.05;
dx=b/m;
sig=1;

q=(-b):dx:b;
U=zeros(N,N);
S=zeros(N2,1); % sin(u)
C=zeros(N2,1); % cos(u)
O=ones(N2,1);
Up=U;
D=zeros(N2,N2); % W(x-y)

% compute distance matrix
for i=1:N
  x=q(i);
  for j=1:N
  y=q(j);
  r=x*x+y*y;
  k=(j-1)*N+i;
    for ip=1:N
        xp=q(ip);
    for jp=1:N;
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

% constant term
DO=D*O*sin(d);

% initialize U
for i=1:N
  for j=1:N
    r=q(i)^2+q(j)^2;
    if ((r>=a2)&(r<=b2))
     % U(i,j)=mod(atan2(q(j),q(i))+2*pi+rand()*.2,2*pi);
     % U(i,j)=2*pi*rand();
      U(i,j)=mod(atan2(q(j),q(i))+2*pi,2*pi);
    end
  end
end

U0=U;
for t=1:1000
   C=cos(U(:)); 
   S=sin(U(:));
   Cd=cos(U(:)+d);
   Sd=sin(U(:)+d);
   DC=D*Cd;
   DS=D*Sd;
   Up(:)=DS.*C-DC.*S-DO;
   U(:)=U(:)+dt*Up(:);
end   
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
figure
    h0=pcolor(q,q,V0);
colormap('hsv')
set(h0,'EdgeColor','none');
figure
h=pcolor(q,q,V);
colormap('hsv');
set(h,'EdgeColor','none');


    
    

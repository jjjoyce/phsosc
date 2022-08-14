%tic

global a0 b0
a0=0.5;
b0=5;
N=200;
h=(b0-a0)/N;

% calculate matrix MF=G
M=zeros(N,N);
M1=zeros(N,N);
M2=zeros(N,N);
G=zeros(N,1);

[a b] = getRadius;

for i=1:N
    for j=1:N
        r = i*h+a;
        s = j*h+a;
        M1(i,j) = g1rs(r,s)-g1rs(a,s);
    end;
    M2(i,i) = G1r(r);
    G(i)=G2r(r)-G2r(a);
end;
M = M2-M1*h;
f=inv(M)*G;

% calculate Omega2
s1 = a+h:h:b;
int = g1rs(a,s1)*f*h;
om2 =-G2r(a)-int

save data.mat a
save('data.mat','M','G','f','om2','-append');
fm=[0;f];



%toc
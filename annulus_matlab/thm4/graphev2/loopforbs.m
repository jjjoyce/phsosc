%% loop a for bstar(a)
global rho

% discrete size
n=100;
bs=zeros(100,1);
bs0=zeros(100,1)+1.2;
bs0(1:87,:)=sab(:,2);
%b=10;
rho=0.25;
for i=80 :1:100
    a=i*0.01;
    b1=bs0(i)+0.5;
    ev1=eigM2(a,b1,n);
    while ev1<0
        b1=b1-0.01;
        ev1=eigM2(a,b1,n);  
    end;
    bs(i)=b1+0.01;
end

% loop for alpha

global al;
omv=zeros(100,1);
fend=zeros(100,1);
data_f=zeros(100,101);
for i=1:100
    al=i/100;
    main;
    fend(i)=fcf(101);
    data_f(i,:)=fcf;
    omv(i)=getOmega(alpha,a,b,fcf);
end;
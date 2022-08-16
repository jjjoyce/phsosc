function left_indices = getIndex(r)

%N = 100;
global N

[alpha a b] = getVariable;
h = (b-a)/N;
rd = a:h:b;

ndata=numel(rd);

left_indices=0;
% Case 1
if r<rd(2) 
    left_indices = 1;
end 

for k=2:ndata-1
  if  (rd(k)<=r) & (r<rd(k+1)) 
      left_indices = k;
  end 
end

if rd(ndata)<=r
    left_indices = ndata;
end

if any(left_indices==0)
  error('bracket: not all indices set!')
end

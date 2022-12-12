function [xmax]=buscador(x,y,J)
xmax=[]; s=0;
while s==0
   k=max(y(1:J(1)));
   k=find(y==k);
   xmax=[xmax,x(k)];
   s=1;
end
for i=2:length(J)
      j=find(y==max(y(J(i-1)+1:J(i))));
      xmax=[xmax,x(j)];
end
v=find(y==max(y(J(length(J))+1:length(y))));
xmax=[xmax,x(v)];

    
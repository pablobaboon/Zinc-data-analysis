function [z,X,P,I,zm]=refinado(sigma,x,y)
    I=[]; P=y; X=x;
  for i=1:length(y)
      if y(i)>sigma
          I=[I,i];
      end
  end
  %l=0;
  %for i=1:length(I)
      %o=length(P);a=P(1:I(i-l)-1); b=P(I(i-l)+1:o); c=x(1:I(i-l)-1); d=x(I(i-l)+1:o);
      %P=[a;b];
      %X=[c;d];
      %l=l+1;
  %end
  for i=1:length(I)
      P=P(P~=y(I(i)));
      X=X(X~=x(I(i)));
  end
  if length(P)+length(y(I))~=length(y)
      disp ('Error en el codigo, revisar dimensiones')
  end

  %Very simple refinement code, to clean and separate signal-noise. 
  s=std(P);
  z=s+mean(y);
  zm=s-mean(y);


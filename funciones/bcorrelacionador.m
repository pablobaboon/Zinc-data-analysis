function [I,P]=bcorrelacionador(x1,x2,e)
I=[]; P=x2;
for i=1:length(x1)
    for j=1:length(x2)
        if abs(x1(i)-x2(j))<e
            I=[I;i,j];
        end
    end
end
for i=1:length(I(:,1))
    P=P(P~=x2(I(i,2)));
end 

            

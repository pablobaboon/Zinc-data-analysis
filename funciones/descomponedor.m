function J=descomponedor(x,d)
J=[];
for i=2:length(x)
    if (x(i)-x(i-1))>d
        J=[J,i-1];
    end 
end



function [c, ceq] = OvEstConstraints(x)
c=[x(3)<0;
    tanh(x(2)*x(3))-x(4)];
ceq=[];
end
ObjectiveFunction = @calibrate3;
ConstraintFunction = @noconstraints;
LB = [0 0 0 -100]';   % Lower bound
UB = [100 1 100 -1]';  % Upper bound
% LB = [0 0 0 1]';   % Lower bound
% UB = [100 1 100 100]';  % Upper bound
nvars = 4;
[x, fval] = PSO(ObjectiveFunction,ConstraintFunction,LB,UB,nvars);
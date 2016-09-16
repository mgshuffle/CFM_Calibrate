ObjectiveFunction = @calibrate3;
ConstraintFunction = @OvEstConstraints;
nvars = 4;    % Number of variables
LB = [0 0 0 0];   % Lower bound
UB = [100 1 100 100];  % Upper bound
options = gaoptimset('MutationFcn',@mutationadaptfeasible);
options = gaoptimset(options,'PlotFcn',{@gaplotbestf},'Display','iter');
% Next we run the GA solver.
[x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB,ConstraintFunction,options);
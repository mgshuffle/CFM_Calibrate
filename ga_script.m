ObjectiveFunction = @calibrate;
nvars = 5;    % Number of variables
LB = [0.25 0 0 0 0];   % Lower bound
UB = [4 30 0.5 100 100];  % Upper bound
% 设置
% [1.8 10 0 5 5; 2.2 20 0.2 20 20] mae起始值
% generation = 50; Fitness Limit = 0;
[x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB);
function [xm,fval] = PSO(fitness,myconstraints,LB,UB,D)
N = 50;
T = 100;

c1 = 1.49618;
c2 = 1.49618;
w = 0.7298;

format long;

%------初始化种群的个体------------

MAT1 = repmat((UB-LB),1,N);
MAT2 = repmat(LB,1,N);
x = rand(D,N).*MAT1 + MAT2;
v = rand(D,N).*MAT1 + MAT2;

%防止出现不符合不满足约束的解
for k = 1:N
    [b,~] = myconstraints(x(:,k));
    while (~isempty(b(b>0)))
        x(:,k) = rand(D,1).*(UB-LB)+LB;
    end
end

p = zeros(1,N);
y = zeros(D,N);
%------先计算各个粒子的适应度，并初始化Pi和Pg----------------------

for i=1:N
    p(i) = fitness(x(:,i));
    y(:,i) = x(:,i);
end

gbest = min(p);
idxs = find(p==gbest);
gx = y(:,idxs(1));


%------进入主要循环，按照公式依次迭代------------



for t=1:T
    display(t);
    v = w*v + c1*rand(D,N).*(y-x) + c2*rand(D,N).*(repmat(gx,1,N)-x);
    x = x + v;
    
%     temp = find(x(2,:)<0);
%     x(2,temp)=rand(1,length(temp));
    
%     %位置修正 防止速度太大越界
%     xx = reshape(x,D*N,1);
%     seq2 = repmat(LB,N,1);    
%     idx2 = find(xx<seq2);
%     xx(idx2) = seq2(idx2);
%     seq3 = repmat(UB,N,1);
%     idx3 = find(xx>seq3);
%     xx(idx3) = seq3(idx3);
%     x = reshape(xx,D,N);
    


    for i=1:N
        a = fitness(x(:,i));
        [b,~] = myconstraints(x(:,i));
        if (a<p(i) && isempty(b(b>0)))
            p(i) = a;
            y(:,i)=x(:,i);
        end     
    end
    gbest = min(p);
    idxs = find(p==gbest);
    gx = y(:,idxs(1));
    
    display(gbest);
    display(gx);
end
xm = gx;
fval = gbest;
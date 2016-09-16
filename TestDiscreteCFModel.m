x = [2.03840130711047,14.2794607272825,0.495634669523070,5.66501589695322,5.85613370118059];
dataset = load('Grade_C_No2.mat');


mydata = dataset.data;
myindex = dataset.index;

total = length(myindex);
[~,IdxBegin,~] = unique(myindex);
veh_count = length(IdxBegin);
IdxEnd = [IdxBegin(2:veh_count)-1;total];

OverEstLast = [];
UnderEstLast = [];
shiftimes = zeros(veh_count,1);
lesscount = zeros(veh_count,1);
last = zeros(veh_count,1);
p = zeros(veh_count,1);

OverEstDataset = [];
UnderEstDataset = [];
figure
hold on
for i = 1:veh_count
    inputdata = mydata(IdxBegin(i):IdxEnd(i),:);
    [Err_i,~,~,gapout,accerr] = CFM_validate(inputdata,x);
    
    plot(gapout,accerr)
    
    idx1 = find(Err_i >= 0);
    idx2 = find(Err_i < 0);
    idx3 = find(accerr >= 0);
    idx4 = find(accerr < 0);
    OverEstLast = [OverEstLast; counter(idx1)];
    UnderEstLast = [UnderEstLast; counter(idx2)];
    
    lesscount(i) = min(length(idx1),length(idx2));
    lesscount2(i) = min(length(idx3),length(idx4));
    
%     if lesscount(i)>5
%         plot(Err_i)
%     end
    
    Err_i(idx1) = 1;
    Err_i(idx2) = -1;
    accerr(idx3) = 1;
    accerr(idx4) = -1;
%     plot(Err_i)
    shiftimes(i) = length(find((diff(Err_i))~=0));
    shiftimes2(i) = length(find((diff(accerr))~=0));
       
    
    last(i) = length(Err_i);
    last2(i) = length(accerr);
    p(i) = 1 - lesscount(i)/last(i);
    p2(i) = 1 - lesscount2(i)/last2(i);
end

eva1 = length(find(p>=0.9))/veh_count;
eva2 = length(find(lesscount>5))/veh_count;
eva3 = length(find(p2>=0.9))/veh_count;
eva4 = length(find(lesscount2>5))/veh_count;

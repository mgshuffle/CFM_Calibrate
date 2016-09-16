x = [2.03840130711047,14.2794607272825,0.495634669523070,5.66501589695322,5.85613370118059];
dataset = load('Grade_C_No2.mat');
short = 10;

data = dataset.data;
index = dataset.index;

total = length(index);
[~,IdxBegin,~] = unique(index);
veh_count = length(IdxBegin);
IdxEnd = [IdxBegin(2:veh_count)-1;total];

IBg = [];
IEnd = [];
Label = [];
for i = 1:veh_count
    inputdata = data(IdxBegin(i):IdxEnd(i),:);
    [Err_i,~,~] = CFM_validate(inputdata,x);
    
    Err_i(Err_i>=0) = 1;%UnderEst
    Err_i(Err_i<0) = -1;%OverEst
    
    diffErr = diff(Err_i);
    idxs = find(diffErr~=0);
    
    lbs = [Err_i(idxs);Err_i(end)];
    
    idxs = idxs + IdxBegin(i) -1;    
    heads = [IdxBegin(i);idxs+1];
    tails = [idxs;IdxEnd(i)];
    
    rm = find(abs(tails - heads + 1)<=short);
    lbs(rm)=[];
    heads(rm)=[];
    tails(rm)=[];
    
    IBg = [IBg; heads];
    IEnd = [IEnd; tails];
    Label = [Label; lbs];
end

UnEst_IBg = IBg(Label==1);
UnEst_IEnd = IEnd(Label==1);

OvEst_IBg = IBg(Label==-1);
OvEst_IEnd = IEnd(Label==-1);
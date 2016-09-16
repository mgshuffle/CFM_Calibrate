% dataset里的data必须按照先按VID,再按FID排好序
function [mae,mape,Err,PErr] = myfitness(x)
dataset = load('Grade_C_No2.mat');
% dataset = load(filename);
mydata = dataset.data;
myindex = dataset.index;

total = length(myindex);
[~,IdxBegin,~] = unique(myindex);
veh_count = length(IdxBegin);
IdxEnd = [IdxBegin(2:veh_count)-1;total];

SumErr = 0;
SumPErr = 0;
SampleCount = 0;
Err = [];
PErr = [];
for i = 1:veh_count
    inputdata = mydata(IdxBegin(i):IdxEnd(i),:);

    [Err_i,PErr_i,SampleCount_i] = CFM_validate(inputdata,x);
    SumErr = SumErr + sum(abs(Err_i));
    SumPErr = SumPErr + sum(abs(PErr_i));
    SampleCount = SampleCount + SampleCount_i;
    
    Err=[Err; Err_i];
    PErr=[PErr; Err_i];
end

mae = SumErr / SampleCount;
mape = SumPErr / SampleCount;
end
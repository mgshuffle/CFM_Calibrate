% dataset里的data必须按照先按VID,再按FID排好序
function mape = calibrate_mape(x)
dataset = load('Straight_Calibration_No3.mat');
mydata = dataset.data;
myindex = dataset.index;

total = length(myindex);
[~,IdxBegin,~] = unique(myindex);
veh_count = length(IdxBegin);
IdxEnd = [IdxBegin(2:veh_count)-1;total];

SumErr = 0;
SumPErr = 0;
SampleCount = 0;

for i = 1:veh_count
    inputdata = mydata(IdxBegin(i):IdxEnd(i),:);
    [AbsErr_i,AbsPErr_i,SampleCount_i] = CFM(inputdata,x);
    SumErr = SumErr + sum(AbsErr_i);
    SumPErr = SumPErr + sum(AbsPErr_i);
    SampleCount = SampleCount + SampleCount_i;
end

% mae = SumErr / SampleCount;
mape = SumPErr / SampleCount;
end
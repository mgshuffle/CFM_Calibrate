% dataset里的data必须按照先按VID,再按FID排好序
function mae = calibrate2(x)
x_ov = [2.03840130711047,14.2794607272825,0.495634669523070,5.66501589695322,5.85613370118059];
dataset = load('PModel_Grade_C_No1');
data = dataset.data;
% index = dataset.index;
IBg = dataset.IBg;
IEnd = dataset.IEnd;
Label = dataset.Label;

count = length(IBg);

SumErr = 0;
SampleCount = 0;

for i = 1:count
    if (Label(i) == 1)%先校准over
        inputdata = data(IBg(i):IEnd(i),:);
        [AbsErr_i,~,SampleCount_i] = P_CFM(inputdata,Label(i),x_ov,x);
        SumErr = SumErr + sum(AbsErr_i);
        SampleCount = SampleCount + SampleCount_i;
    end
end

mae = SumErr / SampleCount;
% mape = SumPErr / SampleCount;
end
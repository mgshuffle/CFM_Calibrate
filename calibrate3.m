% dataset里的data必须按照先按VID,再按FID排好序
function mae = calibrate3(x)
x_ov = [2.03840130711047,14.2794607272825,0.495634669523070,5.66501589695322,5.85613370118059];
dataset = load('PModel_OvEstGrade_C_No1');
data = dataset.data;

IBg = dataset.IBg;
IEnd = dataset.IEnd;

count = length(IBg);

SumErr = 0;
SampleCount = 0;

for i = 1:count
    inputdata = data(IBg(i):IEnd(i),:);        
    [AbsErr_i,~,SampleCount_i] = P2_CFM(inputdata,x_ov,x);
    SumErr = SumErr + sum(AbsErr_i);
    SampleCount = SampleCount + SampleCount_i;
end

mae = SumErr / SampleCount;
end
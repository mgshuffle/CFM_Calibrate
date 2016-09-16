inputdata = xlsread('Grade_C_V_No2.csv');
index = inputdata(:,1);
data = inputdata(:,2:end);

ui = unique(index);
samplecount = length(ui);

vcount = floor(0.3 * samplecount);

index2=[];
data2=[];

ui2=zeros(vcount,1);
for i = 1:vcount
    k = randi([1 samplecount-i+1],1,1);
    ui2(i) = ui(k);
    ui(k) = [];
end

ui2 = sort(ui2);

% ≈≈–Ú”–Œ Ã‚
for i = 1:vcount    
    idxs = find(index==ui2(i));
    data2 = [data2; data(idxs,:)];
    data(idxs,:) = [];
    
    index2 = [index2; index(idxs)];
    index(idxs) = [];
end
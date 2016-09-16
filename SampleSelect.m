data = xlsread('MATLAB_Select.csv');
VID = data(:,2);
totalcount=length(VID);
[UniqueVID,IdxBegin,~] = unique(VID);
IdxEnd = [IdxBegin(2:end)-1; totalcount];

newdata = [];

for i = 1:length(UniqueVID)
    if (IdxEnd(i) - IdxBegin(i) + 1) > 100 %排除太短的记录
        test = data(IdxBegin(i):IdxEnd(i),:);
        gap = test(:,14);
        fid = test(:,3);
        y = diff(gap)./diff(fid);
        if max(abs(y)) < 10 %去除gap突变
            newdata = [newdata;test];
        end
    end    
end

ia = find(newdata(:,14)==10);%去除大车后半部
kill_list = newdata(ia,2);
kill_list = unique(kill_list);
for i = 1:length(kill_list)
    ib = find(newdata(:,2)==kill_list(i)); 
    newdata(ib,:) = [];
end
function result = counter(idxs)
result = [];
n = length(idxs);
p = 1;
count = 1;
while (p<n)
    if (idxs(p+1) - idxs(p) == 1)
        count = count + 1;
    else
        if (count>1)
            result = [result; count];
        end
        count = 1;
    end
    p = p+1;
end
if (count>1)
    result = [result; count];
end
end
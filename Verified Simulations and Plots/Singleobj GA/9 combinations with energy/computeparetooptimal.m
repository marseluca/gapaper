

for k=1:9
    for i=1:48
        normsVector{k}(i,:) = norm([allFitHistories{k}(i,500), allEnergyHistories{k}(i,1)]-[0,0]);
    end
end

paretooptimalVector = [];
paretooptimalIndexes = [];
for k=1:9
    [~, paretooptimalIndexes(end+1)] = min(normsVector{k});
    paretooptimalVector(k,:) = [allFitHistories{k}(paretooptimalIndexes(k),500), allEnergyHistories{k}(paretooptimalIndexes(k),1)];
end
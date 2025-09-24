% for k=1:9
%    allPoints{k} = [];
%    currentRow = allParetoFront(k,:);
%    validCells = currentRow(cellfun(@(x) ~isempty(x) && size(x, 2) == 2, currentRow));
%    allPoints{k} = vertcat(validCells{:});
% end

allPoints = allParetoFront;

for k=1:9
    normsVector{k} = vecnorm(allPoints{k}, 2, 2);
end

paretooptimalVector = zeros(9,2);
paretooptimalIndexes = [];

for k=1:9
    [~, paretooptimalIndexes(end+1)] = min(normsVector{k});
    paretooptimalVector(k,:) = [allPoints{k}(paretooptimalIndexes(k),1), allPoints{k}(paretooptimalIndexes(k),2)];
end

minFinishTime = Inf;
for k=1:9
    [currentMin, currentIdx] = min(allPoints{k}(:,1));

    if currentMin<minFinishTime
        minFinishTime = currentMin;
        minFinishTimeIdx = currentIdx;
        minFinishTimeCellIdx = k;
    end
end

minEnergy = Inf;
for k=1:9
    [currentMin, currentIdx] = min(allPoints{k}(:,2));

    if currentMin<minEnergy
        minEnergy = currentMin;
        minEnergyIdx = currentIdx;
        minEnergyCellIdx = k;
    end
end



% This program filters all the histories with negative constraints
% Starting from allConstHistories and allFitHistories
% And creates new data with only those that respect the constraints

maxGen = 500;
eligibleVec = cell(1,9);

for i=1:9

    eligibleVec{i} = [];

    for r=1:size(allConstHistories{i},1)

        eligible = true;

        for c=1:maxGen+1
            if allConstHistories{i}(r,c)>0
                eligible = false;
                break;
            end
        end

        if eligible
            eligibleVec{i} = [eligibleVec{i}, r];
        end
    end
end

allConstHistoriesNew = cell(1,9);
allFitHistoriesNew = cell(1,9);

for i=1:9
    allConstHistoriesNew{i} = [];

    for j=1:length(eligibleVec{i})
        allConstHistoriesNew{i} = [allConstHistoriesNew{i}; allConstHistories{i}(eligibleVec{i}(j),:)];
        allFitHistoriesNew{i} = [allFitHistoriesNew{i}; allFitHistories{i}(eligibleVec{i}(j),:)];
    end
end
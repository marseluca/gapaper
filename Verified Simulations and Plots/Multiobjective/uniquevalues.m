for k=1:9
    for j=1:50
        allFeasibleParetoPoints{k,j} = unique(allFeasibleParetoPoints{k,j}, 'rows', 'stable');
    end
end

close  all

figure
% Combine all Pareto front points from the cell array
for k=1:9
    allPoints = [];
    for i = 1:48
        allPoints = [allPoints; allFitHistories{k}(i,500), allEnergyHistories{k}(i,1)]; % Concatenate each nx2 array
    end
    
    if ~isempty(allPoints)
        nonDomIdx = true(size(allPoints, 1), 1);
        for i = 1:size(allPoints, 1)
            for j = 1:size(allPoints, 1)
                if i ~= j && all(allPoints(j, :) <= allPoints(i, :)) && any(allPoints(j, :) < allPoints(i, :))
                    nonDomIdx(i) = false;
                    break;
                end 
            end
        end
        allPoints = allPoints(nonDomIdx, :);
    end


    % Extract x and y coordinates
    x = allPoints(:,1);
    y = allPoints(:,2)/1000;
    
    subplot(3,3,k)
    scatter(x,y,15,'filled','Color','k');
    xlabel("Finish time [s]")
    ylabel("Tot. energy [kJ]")
    xlim([83 100])
    ylim([2.5 3.1])
    grid

    sgtitle({"Pareto fronts for the","Single-objective optimization (50 executions)"})
end

totalExecution = 0
for j=1:9
    totalExecution = totalExecution + sum(allExecutionHistories{j});
end

avgExecution = totalExecution/(9*50)
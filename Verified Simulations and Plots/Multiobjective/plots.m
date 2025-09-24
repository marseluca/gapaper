

close  all

CFMR = ["[0.3, 0.01]", "[0.3, 0.05]", "[0.3, 0.1]",...
        "[0.6, 0.01]", "[0.6, 0.05]", "[0.6, 0.1]",...
        "[0.9, 0.01]", "[0.9, 0.05]", "[0.9, 0.1]"];

figure

for k=1:9
    
    allPoints = allParetoFront{k};
    
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
    hold on
    scatter(x,y,15,'filled','DisplayName',"[CF, MR] = "+CFMR(k));
    xlabel("Finish time [s]")
    ylabel("Tot. energy [kJ]")
    xlim([0 500])
    ylim([0 3])
    grid
    legend
    title({"Pareto fronts for the","Multi-objective optimization (50 executions)"})
end


% minTime = Inf;
% minEnergy = Inf;
% for k=1:9
%     [currentMin, currentMinIdx] = min(allParetoPoints{k}(:,1));
%     [EcurrentMin, EcurrentMinIdx] = min(allParetoPoints{k}(:,2));
%     if currentMin<minTime
%         minTime = currentMin;
%         minTimeIdx = currentMinIdx;
%         minTimeComb = k;
%     end
% 
%     if EcurrentMin<minEnergy
%         minEnergy = EcurrentMin;
%         minEnergyIdx = EcurrentMinIdx;
%         minEnergyComb = k;
%     end
% end
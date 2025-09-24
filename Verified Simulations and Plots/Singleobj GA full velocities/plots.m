%% BOXCHART COMBINATIONS

plotfit = true;


if plotfit==0
    %% CONST HISTORIES

    close all
    
    figure
    
    allValues = [];
    genSteps = 5;
    maxGens = 500;
    nExecutions = 48;
    
    % Puoi usare anche ndgrid
    CFMR = ["[0.3, 0.01]", "[0.3, 0.05]", "[0.3, 0.1]",...
         "[0.6, 0.01]", "[0.6, 0.05]", "[0.6, 0.1]",...
         "[0.9, 0.01]", "[0.9, 0.05]", "[0.9, 0.1]"];
    
    for k=1:9
        for j=1:nExecutions
           allValues(j,:) = allConstHistories{k}(j,maxGens);
        end
    
        subplot(3,3,k)
        boxchart(allValues)
        title("[CF, MR] = "+CFMR(k))
        xlabel("Generations")
        ylabel("Offset [m]")
        ylim([-2 0.5])
        set(gca,'XTickLabel',{"500"});
    
        sgtitle({"Constraint offsets distribution for the","Maximum velocities approach (50 executions)"});
    
        grid on
    end

else
    %% CONST HISTORIES
    
    close all
    
    figure
    
    allValues = [];
    genSteps = 5;
    maxGens = 500;
    nExecutions = 48;
    
    % Puoi usare anche ndgrid
    CFMR = ["[0.3, 0.01]", "[0.3, 0.05]", "[0.3, 0.1]",...
         "[0.6, 0.01]", "[0.6, 0.05]", "[0.6, 0.1]",...
         "[0.9, 0.01]", "[0.9, 0.05]", "[0.9, 0.1]"];
    
    for k=1:9
        for j=1:nExecutions
            allValues(j,:) = allFitHistories{k}(j,maxGens);
        end
    
        subplot(3,3,k)
        boxchart(allValues)
        title("[CF, MR] = "+CFMR(k))
        xlabel("Generations")
        ylabel("Best fit [s]")
        ylim([95 200])
        set(gca,'XTickLabel',{"500"});
    
        sgtitle({"Best fits distribution for the","Maximum velocities approach (50 executions)"});
    
        grid on
    end
end
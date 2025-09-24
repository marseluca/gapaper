%% BOXCHART COMBINATIONS

plotfit = true;


if plotfit==0
    %% CONST HISTORIES

    close all
    
    figure
    
    allValues = [];
    genSteps = 5;
    maxGens = 500;
    nExecutions = 41;
    
    % Puoi usare anche ndgrid
    CFMR = ["[0.3, 0.01]", "[0.3, 0.05]", "[0.3, 0.1]",...
         "[0.6, 0.01]", "[0.6, 0.05]", "[0.6, 0.1]",...
         "[0.9, 0.01]", "[0.9, 0.05]", "[0.9, 0.1]"];
    
    for k=1:9
        for i=1:genSteps
    
            for j=1:nExecutions
                allValues(j,i) = allConstHistories{k}(j,i*maxGens/genSteps);
            end
    
        end
    
        subplot(3,3,k)
        boxchart(allValues)
        title("[CF, MR] = "+CFMR(k))
        xlabel("Generations")
        ylabel("Offset [m]")
        ylim([-2 0.5])
        set(gca,'XTickLabel',{"100","200","300","400","500"});
    
        sgtitle({"Constraint offset histories distribution for the","Maximum velocities approach (50 executions)"});
    
        grid on
    end

else
    %% FIT HISTORIES
    
    close all
    
    figure
    
    allValues = [];
    genSteps = 5;
    maxGens = 500;
    nExecutions = 41;
    
    % Puoi usare anche ndgrid
    CFMR = ["[0.3, 0.01]", "[0.3, 0.05]", "[0.3, 0.1]",...
         "[0.6, 0.01]", "[0.6, 0.05]", "[0.6, 0.1]",...
         "[0.9, 0.01]", "[0.9, 0.05]", "[0.9, 0.1]"];
    
    for k=1:9
        for i=1:genSteps
    
            for j=1:nExecutions
                allValues(j,i) = allFitHistories{k}(j,i*maxGens/genSteps);
            end
    
        end
    
        subplot(3,3,k)
        boxchart(allValues)
        title("[CF, MR] = "+CFMR(k))
        xlabel("Generations")
        ylabel("Best fit [s]")
        ylim([90 240])
        set(gca,'XTickLabel',{"100","200","300","400","500"});
    
        sgtitle({"Best fit histories distribution for the","Maximum velocities approach (50 executions)"});
    
        grid on
    end
end

for i=1:9
    sum(allFitHistories{i}(1:40,500))/40
end
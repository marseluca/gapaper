function [state, options, optchanged] = o_saveBestFit(options, state, flag)
    global bestFitHistory;
    
    % Initialize bestFitHistory on first generation
    if isempty(bestFitHistory)
        bestFitHistory = [];
    end
    
    % Save the best fitness value from the current generation
    bestFitHistory = [bestFitHistory; state.Score(1, :)]; % Track the minimum score (best fit)
    
    % No changes to options
    optchanged = false;
end

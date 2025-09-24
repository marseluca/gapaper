function timeSteps = pp_getTimeStepsForDistances(trajectories,maxTimeStep,distanceSampling)
    
    % Find trajectory with the longest time samples
    [~, maxSamplesIndex] = max(cellfun(@(t) t.t_tot(end), trajectories));
    
    timeSteps = trajectories{maxSamplesIndex}.t_tot(1:maxTimeStep); % Time steps corresponding to the minimum distances

end

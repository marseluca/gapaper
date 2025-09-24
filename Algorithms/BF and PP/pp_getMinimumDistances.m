function minDistances = pp_getMinimumDistances(trajectories)
    
    global nRobots;
    
    k = 1;

    maxLength = max(arrayfun(@(i) length(trajectories{i}.x_tot), 1:nRobots));
    distances = Inf(maxLength, nRobots * (nRobots - 1) / 2); % Preallocate distances cell array
    
    for i = 1:nRobots
        for j = i + 1:nRobots
            % Get all the distances over time
            maxLength = min(length(trajectories{i}.x_tot), length(trajectories{j}.x_tot));
            distance = sqrt((trajectories{i}.x_tot(1:maxLength) - trajectories{j}.x_tot(1:maxLength)).^2 + ...
                                (trajectories{i}.y_tot(1:maxLength) - trajectories{j}.y_tot(1:maxLength)).^2);
            distances(1:maxLength,k) = distance';
            k = k + 1;
        end
    end

    minDistances = min(distances, [], 2);
    minDistances = minDistances';
    
end

function [minDistances, minCouples] = pp_getMinimumDistances2(trajectories)
    
    global nRobots;
    
    k = 1;

    maxLength = max(arrayfun(@(i) length(trajectories{i}.x_tot), 1:nRobots));
    distances = Inf(maxLength, nRobots * (nRobots - 1) / 2); % Preallocate distances cell array

    minDistances = Inf(1, maxLength); % Store only the minimum at each time step
    minCouples = cell(1,maxLength);

    for t = 1:maxLength
        for i = 1:nRobots
            for j = i+1:nRobots
                minLength = min(length(trajectories{i}.x_tot), length(trajectories{j}.x_tot));
                if t<=minLength
                    distance = sqrt((trajectories{i}.x_tot(t) - trajectories{j}.x_tot(t))^2 + ...
                                    (trajectories{i}.y_tot(t) - trajectories{j}.y_tot(t))^2);
                    if distance<minDistances(t)
                        minCouples{t} = [i j];
                    end
                    minDistances(t) = min(minDistances(t), distance);
                end
            end
        end
    end

    
end
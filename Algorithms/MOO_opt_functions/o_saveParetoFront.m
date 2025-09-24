function [state, options, optchanged] = o_saveParetoFront(options, state, flag)
    % Custom Output Function for Saving Pareto Front (Feasible Solutions Only)
    % 
    % Saves the Pareto front only if the constraints are satisfied.

    global paretoFront feasibleParetoPoints paths delta_s
    
    optchanged = false; % Default is no change to options
    
    switch flag
        case 'init'
            paretoFront = [];
            feasibleParetoPoints = [];
            % disp('Initializing custom Pareto Front output function...');
        
        case 'iter'
            % Get current population and objective function values
            population = state.Population;
            scores = state.Score;
            
            % Check constraints for each individual in the population
            for i = 1:size(population, 1)
                constraintValue = o_collision_constraint(population(i, :), paths, delta_s);
                
                % Save only if constraints are satisfied (all constraint values <= 0)
                if constraintValue <= 0
                    paretoFront = [paretoFront; scores(i, :)];
                    feasibleParetoPoints = [feasibleParetoPoints; population(i, :)];
                end
            end

            % Filter non-dominated solutions manually
            if ~isempty(paretoFront)
                nonDomIdx = true(size(paretoFront, 1), 1);
                for i = 1:size(paretoFront, 1)
                    for j = 1:size(paretoFront, 1)
                        if i ~= j && all(paretoFront(j, :) <= paretoFront(i, :)) && any(paretoFront(j, :) < paretoFront(i, :))
                            nonDomIdx(i) = false;
                            break;
                        end
                    end
                end
                paretoFront = paretoFront(nonDomIdx, :);
                feasibleParetoPoints = feasibleParetoPoints(nonDomIdx, :);
            end
        % 
        % case 'done'
        %     % Save Pareto Front data at the end

    end
end

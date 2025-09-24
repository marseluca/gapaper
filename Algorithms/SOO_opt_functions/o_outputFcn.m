function [state, options, optchanged] = o_outputFcn(options, state, flag)
    optchanged = false;  % Default is no change to options
    global maxGen;
    global paths delta_s;
    % Store the best fitness and constraint violations for plotting
    global bestFitHistory constraintHistory;

    % Get the current generation and best fitness
    gen = state.Generation + 1;  % Add 1 so gen starts from 1 instead of 0
    [~, idx] = min(state.Score); 
    x_opt = state.Population(idx, :); % Best solution so far (x_opt)

    % Evaluate constraints for the best solution
    [cineq, ~] = o_collision_constraint(x_opt,paths,delta_s);  % Replace with your constraint function name
    maxConstraintViolation = max(cineq); % Max constraint violation
    
    % Initialize bestFitHistory on first generation
    if isempty(bestFitHistory)
        bestFitHistory = [];
    end
    bestFitness = o_objective(x_opt,paths);

    % Log the constraint violations
    % fprintf('Generation %d: Best Fitness = %.4f, Max Constraint Violation = %.4f\n', gen - 1, bestFitness, maxConstraintViolation);

    if gen == 1
        bestFitHistory = [];  % Initialize at the first generation
        constraintHistory = [];
    end
    bestFitHistory = [bestFitHistory, bestFitness];  % Append best fitness
    constraintHistory = [constraintHistory, maxConstraintViolation];  % Append max constraint violation

    % Stop execution after maxGen generations
    if gen >= maxGen
        state.StopFlag = 'y';  % Stop execution
    end
end

function [state, options, optchanged] = o_outputFcn3(options, state, flag)

    global maxGen paths delta_s nRobots;
    optchanged = false;

    % Get the current generation and best fitness
    % Add 1 so gen starts from 1 instead of 0
    gen = state.Generation + 1;

    constraints = [];
    for k=1:length(state.Population)
        [c, ceq] = o_collision_constraint(state.Population(k,:),paths,delta_s);
        constraints = [constraints, c];
    end

    feasible_indexes = find(constraints < 0);
    feasibleScores = state.Score(feasible_indexes);

    [minFinishTime, idx] = min(feasibleScores);
    minFinishTimeIndex = feasible_indexes(idx);

    bestSolution = state.Population(minFinishTimeIndex,:);
    bestSolutionString = string(mat2str(round(bestSolution,2)));

    trajectories = {};
    minFinishTimeComputed = 0;
    for j=1:nRobots
        trajectories{j} = pp_interpolatePath2(paths{j},bestSolution(j),0,0);
        minFinishTimeComputed = max(trajectories{j}.t_tot(end),minFinishTimeComputed);
    end

    fprintf("Gen: %d | Best score: %.2f | Best solution: %s\n",gen,minFinishTime,bestSolutionString)
    

    % Stop execution after maxGen generations
    if gen >= maxGen

        state.StopFlag = 'y';  % Stop execution

    end
end

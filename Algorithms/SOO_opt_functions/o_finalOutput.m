function finaloutput = o_finalOutput(population,scores)

    global paths delta_s;

    constraints = [];
    for k=1:length(population)
        [c, ~] = o_collision_constraint(population(k,:),paths,delta_s);
        constraints = [constraints, c];
    end

    feasible_indexes = find(constraints <= 0);
    feasibleScores = scores(feasible_indexes);

    [minFinishTime, idx] = min(feasibleScores);
    minFinishTimeIndex = feasible_indexes(idx);

    bestSolution = population(minFinishTimeIndex,:);
    bestSolutionString = string(mat2str(round(bestSolution,2)));

    fprintf("Final best score: %.2f | Associated solution: %s\n",minFinishTime,bestSolutionString)
    
end

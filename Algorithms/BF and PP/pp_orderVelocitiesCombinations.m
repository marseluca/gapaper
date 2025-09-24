function orderedVelocities = pp_orderVelocitiesCombinations(combinations,targetVelocity)
    
    % This function finds the velocities that are:
    % - Most similar between each other
    % - Closer to 20

    % Number of vectors
    num_vectors = size(combinations, 1);
    length_vectors = size(combinations, 2);
    combinationsAndScores = zeros(num_vectors,length_vectors+1);
    
    % Initialize the minimum score and the index of the closest vector
    min_score = inf;
    closest_idx = 1;
    alpha = 1;
    beta = 1;
    
    % Loop over each vector
    for i = 1:num_vectors
        
        fprintf("Vector #%d out of %d\n",i,num_vectors);
        % Current vector
        current_vector = combinations(i,:);
        combinationsAndScores(i,2:end) = combinations(i, :);

        % Calculate the sum of absolute differences from target velocity
        diff_sum = sum(abs(current_vector - targetVelocity));
        
        % Calculate the variance of the elements in the vector
        variance = var(current_vector);
        
        % Objective function: Weighted sum of deviations and variance
        score = alpha * diff_sum + beta * variance;

        combinationsAndScores(i,1) = score;
       
    end
    
    % Sort velocities combinations depending on their score
    orderedVelocities = sortrows(combinationsAndScores, 1, 'ascend');
end


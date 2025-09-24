function optimizedVector = pp_collisionFreeVelocities1(paths,collisionThreshold)

    %% SOLVE COLLISIONS
    % velStep is the reduction step for the velocities
    % for example, if the max velocity is 20, the algorithm
    % will try to reduce the velocity by 2 every time
    % so that it will try different combinations for 20, 18, 16 m/s and so on
    global nRobots maxVelocity;
    
    tic
    velStep = 0.1;
    minVelocity = 0.9;
    velocityCombinations = pp_velocitiesCombinations(nRobots,maxVelocity,minVelocity,velStep);
    collisionFreeVelocityCombinations = [];

    for i = 1:size(velocityCombinations,1)

        ncomb = ((maxVelocity-minVelocity)/velStep+1)^nRobots;
        fprintf("Combination #%d out of %d\n",i,ncomb);

        % Compute the current combination for the max velocities
        for j=1:nRobots
            vmax = velocityCombinations(i,j);
            trajectories{j} = pp_interpolatePath2(paths{j},vmax,0,0);
        end

        % Check if there are collisions with the current combination
        % collisions = {};
        % for k=1:nRobots
        %     collisions{k} = pp_checkCollisionForOneRobot(paths,trajectories,collisionThreshold,k);
        % end

        distances = pp_getMinimumDistances(trajectories);
        minDistance = min(distances);

        if minDistance>=collisionThreshold
            disp("No collisions for this combination!!!!!!!!!!!!!!!");
            collisionFreeVelocityCombinations = [collisionFreeVelocityCombinations; velocityCombinations(i,:)];
        end


        % if i>1000
        %     break;
        % end

    end

    fprintf("Optimizing velocities...");
    targetVelocity = maxVelocity;
    optimizedVector = pp_optimizeVelocities(collisionFreeVelocityCombinations,1,1,targetVelocity);

    fprintf("Optimized combination: [");
    fprintf("%d ",optimizedVector);
    fprintf("]");

    toc
end


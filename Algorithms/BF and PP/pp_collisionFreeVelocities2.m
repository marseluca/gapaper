function optimizedVector = pp_collisionFreeVelocities2(paths,collisionThreshold)

    %% SOLVE COLLISIONS
    
    global nRobots maxVelocity;

    % Plan the path based on the distance of the starting point of the
    % trajectories to the goal point. The further starting points are given
    % the priority in planning the path, the closest ones are scaled in
    % velocity
    goalPoint = paths{1}(end,:);
    distances = [];
    optimizedVector = [maxVelocity];

    for j=1:nRobots

        % Calculate paths' distances
        totalDistance = 0;
        for i=2:size(paths{j},1)
            segmentDistance = norm(paths{j}(i-1,:)-paths{j}(i,:));
            totalDistance = totalDistance + segmentDistance;
        end

        distances = [distances; totalDistance, j];

    end
    
    orderedDistances = sortrows(distances,1,'descend');

    % Reorder the robots based on the distances
    orderedPaths = {};
    for j=1:nRobots
        orderedPaths{j} = paths{orderedDistances(j,2)};
    end

    % Set the max velocity of the first trajectory to the maximum possible
    trajectories = {};
    trajectories{1} = pp_interpolatePath2(orderedPaths{1},maxVelocity,0,0);

    % Compute the max velocity of the other trajectories to avoid collision
    decreaseFactor = 0.01;
    maxVel = maxVelocity;
    for j=2:nRobots

        % Try decreasimg the velocity every time by a decreaseFactor
        for currentVel=maxVel:-decreaseFactor:decreaseFactor

            vmax = currentVel;
            
            trajectories{j} = pp_interpolatePath2(orderedPaths{j},vmax,0,0);

            collisions = pp_checkCollisionForOneRobot(paths,trajectories,collisionThreshold,j);

            if isempty(collisions)
                optimizedVector = [optimizedVector, currentVel];
                break;
            end
        end
    end

    % Reorder the velocities vector
    reorderedOptimizedVector = zeros(1,nRobots);
    for i=1:nRobots
        j = orderedDistances(i,2);
        reorderedOptimizedVector(j) = optimizedVector(i);
    end
    optimizedVector = reorderedOptimizedVector;
    
    toc
    
    fprintf("\n\nMax velocity: [");
    fprintf("%d ",maxVel);
    fprintf("]\n");
    fprintf("Optimized combination: [");
    fprintf("%d ",optimizedVector);
    fprintf("]");


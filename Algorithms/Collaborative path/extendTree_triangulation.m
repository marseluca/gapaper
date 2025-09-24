%% Function to extend the tree towards a target point
function [middle_done, tree, nearNodes, newNode, rewiredNodes, nearestNode]= extendTree_triangulation(middle_done, middle_points, max_x, min_x, max_y, min_y, tree, rewiringRadius, map, triangulation)
    randomPoint =  randomPoint_triangulation(max_x, min_x, max_y, min_y, middle_points, middle_done); %%coordinates
    nearestNode = findNearestNode_triangulation(tree, randomPoint); %nearestNode is a complete node
    newNode = steer_triangulation(nearestNode, randomPoint);

    rewiredNodes=[];
    nearNodes=[];

    collision2=isCollision2_triangulation(nearestNode.position, newNode.position, triangulation);
    
    if ~isCollision1_triangulation(nearestNode.position, newNode.position, map) 
        
        tree.nodes = [tree.nodes; newNode];
        middle_done=[middle_done; newNode.position];
    
    
    
        % Find nearby nodes within the rewiring radius
        nearNodes = findNodesWithinRadius(tree, newNode, rewiringRadius);
    
        % Initialize list of rewired nodes
        %rewiredNodes = [];
    
        % Iterate through each nearby node
        for i = 1:length(nearNodes)
            % Check if rewiring would create a better path
            if nearNodes(i).position ~= newNode.parent.position  % Ensure not connecting to current parent to avoid cycles
                if ~isCollision2_triangulation(nearNodes(i).position, newNode.position, triangulation)
                    % Calculate tentative cost if rewired to newNode
                    %tentativeCost = nearNodes(i).cost + distance(nearNodes(i).position, newNode.position);
                    %tentativeCost = newNode.cost + distance(nearNodes(i).position, newNode.position);
                    %tentativeCost = newNode.cost + pdist([nearNodes(i).position; newNode.position], 'euclidean');
                    tentativeCost = newNode.cost + norm(nearNodes(i).position - newNode.position);
    
                    % Check if tentative cost is lower than current cost
                    if tentativeCost < nearNodes(i).cost
                        % Update parent and cost of the nearby node
                        nearNodes(i).parent = newNode;
                        nearNodes(i).cost = tentativeCost;
    
                        % Collect the rewired node
                        rewiredNodes = [rewiredNodes nearNodes(i)];
                    end
                end
    
            end
        end
    
    end
    
    

    

end

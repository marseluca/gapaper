%% Function to extend the tree towards a target point
function [tree, nearNodes,const,newNode, rewiredNodes, exceedNodes,toc1,toc2]= extendTree(max_x, min_x, max_y, min_y, tree, maxDistance, rewiringRadius, map, safety_margin)
    tic;
    exceedNodes=false;
    randomPoint = [(max_x-min_x)*rand()+min_x, (max_y-min_y)*rand()+min_y]; %%coordinates
    nearestNode = findNearestNode(tree, randomPoint); %nearestNode is a complete node
    newNode = steer(nearestNode, randomPoint, maxDistance);
    
    if ~isCollision(nearestNode.position, newNode.position, map, safety_margin) % Implement collision checking
        % disp('Before concatenation:');
        % disp(tree.nodes);

        tree.nodes = [tree.nodes; newNode];
        if size(tree.nodes,1)>1000
            exceedNodes=true;
            nearNodes=0;
            const=0;
            rewiredNodes=0;
            toc1=toc;
            toc2=0;
            return;
        end
        % disp('After concatenation:');
        % for i=1:size(tree.nodes,1)
        % disp(tree.nodes(i));
        % end
        
        
    end

    toc1=toc;
    tic;
    % Find nearby nodes within the rewiring radius
    nearNodes = findNodesWithinRadius(tree, newNode, rewiringRadius);
    
    % Initialize list of rewired nodes
    rewiredNodes = [];

    % Iterate through each nearby node
    for i = 1:length(nearNodes)
        % Check if rewiring would create a better path
        if nearNodes(i).position ~= newNode.parent.position  % Ensure not connecting to current parent to avoid cycles
            % Calculate tentative cost if rewired to newNode
            tentativeCost = nearNodes(i).cost + distance(nearNodes(i).position, newNode.position);

            % Check if tentative cost is lower than current cost
            if tentativeCost < newNode.cost
                % Update parent and cost of the nearby node
                nearNodes(i).parent = newNode;
                nearNodes(i).cost = tentativeCost;

                % Collect the rewired node
                rewiredNodes = [rewiredNodes nearNodes(i)];
            end
        end
    end

    const=10;

    toc2=toc;
end


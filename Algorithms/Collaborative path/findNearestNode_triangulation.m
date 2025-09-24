function nearestNode = findNearestNode_triangulation(tree, target)
    % Initialize variables
    nodes = tree.nodes;
    numNodes = numel(nodes);

    % Initialize nearest node information
    minDistance = inf;
    nearestNode = Node.empty(0, 1);

    % Iterate through each node in the tree
    for i = 1:numNodes
        % Get the position of the current node
        nodePosition = nodes(i).position;

        % Calculate the Euclidean distance from the node to the target
        distance = norm(nodePosition - target);

        % Check if this node is closer to the target than the current nearest node
        if distance < minDistance
            % Update nearest node information
            minDistance = distance;
            nearestNode = nodes(i);
        end
    end
end
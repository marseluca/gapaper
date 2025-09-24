function nearNodes = findNodesWithinRadius(tree, targetNode, radius) %targetNode is a complete node
    targetPosition = targetNode.position;
    nodePositions = vertcat(tree.nodes.position);  
    distances = sqrt(sum((nodePositions - targetPosition).^2, 2));
    % nearNodes = tree.nodes(distances <= radius);
    indices = find(distances <= radius);

    index_target = find(nodePositions == targetNode.position);
    
    indices = setdiff(indices, index_target);  
    
    nearNodes = tree.nodes(indices);
end
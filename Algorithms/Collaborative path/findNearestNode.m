function nearestNode = findNearestNode(tree, target) %%target is the coordinates of the randomPoint
    distances = sqrt(sum((vertcat(tree.nodes.position) - repmat(target, length(tree.nodes), 1)).^2, 2)); %%compute distances between target and all node positions
    [~, idx] = min(distances);
    nearestNode = tree.nodes(idx);
end
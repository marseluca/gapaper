function path = findPath(tree, goalNode)
    currentNode = goalNode;
    path = [];
    while ~isempty(currentNode)
        path = [currentNode.position; path];
        currentNode = currentNode.parent;
    end
end
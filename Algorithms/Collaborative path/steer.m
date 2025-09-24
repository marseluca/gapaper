function newNode = steer(fromNode, randomPoint, maxStepSize)%% from node is a complete node, randomPoint is just coordinates
    
    direction = (randomPoint - fromNode.position);
    distance = norm(direction);
    newNode = Node();
    if distance <= maxStepSize
        newNode.position = randomPoint;
    else
        % newNode = Node();
        newNode.position = fromNode.position + (direction / distance) * maxStepSize;
    end
    newNode.parent = fromNode;
    newNode.cost = fromNode.cost + norm(newNode.position - fromNode.position);
end

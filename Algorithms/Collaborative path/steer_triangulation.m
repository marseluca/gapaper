function newNode = steer_triangulation(fromNode, randomPoint)%% from node is a complete node, randomPoint is just coordinates
    newNode=Node();
    newNode.position=randomPoint;
    newNode.parent = fromNode;
    newNode.cost = fromNode.cost + norm(newNode.position - fromNode.position);
end

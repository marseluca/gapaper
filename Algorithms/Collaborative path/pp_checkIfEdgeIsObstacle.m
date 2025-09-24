function isObstacle = pp_checkIfEdgeIsObstacle(edge,mapLines)
    
    
    isObstacle = false;
    edge = sort(edge);

    for j=1:size(mapLines,1)

        mapLine = sort(mapLines(j,:));

        if isequal(mapLine,edge)
            isObstacle = true;
            return;
        end

    end
    
end


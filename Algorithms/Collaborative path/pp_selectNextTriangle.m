function selectedTriangle = pp_selectNextTriangle(currTriangleIndex,selectableTriangles,visitedTrianglesSequences,mapLines);
    
    
    % Select the next triangle as the one that contains more paths
    
    maxCount = -Inf;
    selectedTriangle = 0;
    for j=1:length(selectableTriangles)

        count = 0;
        for i=1:size(visitedTrianglesSequences,2)
            if ismember(selectableTriangles(j),visitedTrianglesSequences{i})
                count = count+1;
            end
        end

        if count>maxCount
            
            CommonEdge = pp_findCommonEdge(currTriangleIndex,selectableTriangles(j));
            obstacle = pp_checkIfEdgeIsObstacle(CommonEdge,mapLines);

            if ~obstacle
                maxCount = count;
                selectedTriangle = selectableTriangles(j);
            end
        end
    end
    
end


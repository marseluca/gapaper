function liness = pp_addObstacleToEmptyTriangle(currTriangleIndex,adjacentTriangleIndex,mapLines,k)
        
        % Add an obstacle to an empty adjacent triangle
        % Only if it is not already an obstacle
        
        global triangulation;
        global addedLines;

        CommonEdge = pp_findCommonEdge(currTriangleIndex,adjacentTriangleIndex);
        
        % Find the lines of the adjacent triangles
        currentAdjacentTriangle = triangulation.ConnectivityList(adjacentTriangleIndex,:);
        AdjacentLine1 = sort([currentAdjacentTriangle(1), currentAdjacentTriangle(2)]);
        AdjacentLine2 = sort([currentAdjacentTriangle(1), currentAdjacentTriangle(3)]);
        AdjacentLine3 = sort([currentAdjacentTriangle(2), currentAdjacentTriangle(3)]);
        
        % ONLY for the goal point:
        % Add the line to the obstacles, that is neither:
        % - An obstacle
        % - A common line with the current line
        % This is only necessary for the goal point (k==1)
        % Otherwise the triangulation fails
        
        if k==1
            if ~ismember(sort(AdjacentLine1),sort(mapLines,2),'rows') && ~isequal(sort(CommonEdge),sort(AdjacentLine1))
                addedLines = [addedLines; AdjacentLine1];
            elseif ~ismember(sort(AdjacentLine2),sort(mapLines,2),'rows') && ~isequal(sort(CommonEdge),sort(AdjacentLine2))
                addedLines = [addedLines; AdjacentLine2];
            elseif ~ismember(sort(AdjacentLine3),sort(mapLines,2),'rows') && ~isequal(sort(CommonEdge),sort(AdjacentLine3))
                addedLines = [addedLines; AdjacentLine3];
            end
        else
            if ~ismember(sort(CommonEdge),sort(mapLines,2),'rows')
                addedLines = [addedLines; CommonEdge];
            end
        end
    
end


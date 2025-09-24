function liness = pp_addObstacleToExcludedTriangles(currTriangleIndex,selectedTriangle,selectableTriangles)
    
    % This function creates the obstacles on the excluded triangles

    global addedLines;

    % Create the vector of excluded triangles
    % That contains all the triangles that contain paths
    % except the selected triangle
    excludedTriangles = selectableTriangles;
    excludedTriangles(excludedTriangles==selectedTriangle) = [];

    % Create the obstacle between the excluded triangles and the current
    for i=1:length(excludedTriangles)
        CommonEdge = pp_findCommonEdge(currTriangleIndex,excludedTriangles(i));
        addedLines = [addedLines; CommonEdge];
    end

end


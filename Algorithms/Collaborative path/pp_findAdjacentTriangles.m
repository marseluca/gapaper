function adjacentTriangles = pp_findAdjacentTriangles(triangle)
    
    % This function computes the adjacent triangles of the input triangle
    % from the connectivity list

    % INPUT: 35
    % OUTPUT: 23 45 72
    
    global triangulation;
    
    % Two adjacent triangles have two vertices in common
    adjacentTriangles = [];
    currentTriangle = triangulation.ConnectivityList(triangle,:);

    for j=1:size(triangulation.ConnectivityList,1)
        selectedTriangle = triangulation.ConnectivityList(j,:);
        commonVertices = intersect(currentTriangle,selectedTriangle);
        numberOfCommonVertices = length(commonVertices);

        if numberOfCommonVertices==2
            adjacentTriangles = [adjacentTriangles, j];
        end

    end
   
end


function CommonLine = pp_findCommonEdge(triangle1Index,triangle2Index)
    
    % This function returns the common edge between two triangles
    % Given the index of the two triangle as a scalar
    % That is, their index in the connectivity list
    
    % INPUT: 23 45 (triangle indexes in the connectivity list)
    % OUTPUT: 52 32 (pointA and pointB indexes in the points list)

    global triangulation;

    currentAdjacentTriangle = triangulation.ConnectivityList(triangle1Index,:);
    endTriangleIndex = triangulation.ConnectivityList(triangle2Index,:);

    AdjacentLine1 = sort([currentAdjacentTriangle(1), currentAdjacentTriangle(2)]);
    AdjacentLine2 = sort([currentAdjacentTriangle(1), currentAdjacentTriangle(3)]);
    AdjacentLine3 = sort([currentAdjacentTriangle(2), currentAdjacentTriangle(3)]);

    EndLine1 = sort([endTriangleIndex(1), endTriangleIndex(2)]);
    EndLine2 = sort([endTriangleIndex(1), endTriangleIndex(3)]);
    EndLine3 = sort([endTriangleIndex(2), endTriangleIndex(3)]);

    CommonLine = intersect([AdjacentLine1; AdjacentLine2; AdjacentLine3],[EndLine1; EndLine2; EndLine3],'rows');

end


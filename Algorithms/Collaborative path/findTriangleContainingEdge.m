function triangleIndex = findTriangleContainingEdge(connectivityList, edge, visitedTriangles)
    % edge is a vector [i j] representing the edge to find
    % connectivityList is the ConnectivityList of the triangulation

    % Initialize triangleIndex to NaN (not found)
    triangleIndex = 0;

    % Iterate through each row (triangle) in the ConnectivityList
    for k = 1:size(connectivityList, 1)
        % Extract the vertices of the current triangle
        vertices = connectivityList(k, :);

        % Check if both vertices of the edge are present in the triangle
        if any(ismember(edge(1), vertices)) && any(ismember(edge(2), vertices)) && ~visitedTriangles(k)
            % Found the triangle that contains the edge [i j]
            triangleIndex = k;
            break;  % Exit the loop once the triangle is found
        end
    end
end
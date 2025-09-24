function virtualEdges = findVirtualEdges(nRowNode, triangulation, realEdges)
    % Extract the vertices of the specified triangle
    triangleVertices = triangulation.ConnectivityList(nRowNode, :);

    % Initialize list to store virtual edges
    virtualEdges = [];

    % Check each edge of the triangle
    for k = 1:3
        % Get vertex indices for the current edge
        vertex1 = triangleVertices(k);
        vertex2 = triangleVertices(mod(k, 3) + 1);  % Next vertex in the triangle

        % Form the edge as a pair of vertex indices
        edge = sort([vertex1, vertex2]);  % Ensure consistent edge representation

        % Check if this edge is not a real edge (i.e., virtual edge)
        isRealEdge = false;
        for m = 1:size(realEdges, 1)
            if isequal(realEdges(m, :), edge)
                isRealEdge = true;
                break;  % Found a match, it's a real edge
            end
        end

        % If not a real edge, it's a virtual edge
        if ~isRealEdge
            virtualEdges = [virtualEdges; edge];
        end
    end
end
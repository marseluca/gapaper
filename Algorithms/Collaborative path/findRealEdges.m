function realEdges=findRealEdges(nRowNode, triangulation, map) %nRowNode is the triangle (n-th row of Conn. List) in which the node is 
    
    % edgesCoordinates=[];
    % coordinates1=[triangulation.Points(triangulation.ConnectivityList(nRowNode,1),:); triangulation.Points(triangulation.ConnectivityList(nRowNode,2),:)];
    % coordinates2=[triangulation.Points(triangulation.ConnectivityList(nRowNode,2),:); triangulation.Points(triangulation.ConnectivityList(nRowNode,3),:)];
    % coordinates3=[triangulation.Points(triangulation.ConnectivityList(nRowNode,1),:); triangulation.Points(triangulation.ConnectivityList(nRowNode,3),:)];
    % 
    % 
    % for i=1:size(map.lines,1)
    %     c1=map.points(map.lines(i,1),:);
    %     c2=map.points(map.lines(i,2),:);
    %     c=[c1; c2];
    % 
    %     if c == coordinates1
    %         edgesCoordinates=[edgesCoordinates; coordinates1];
    %     elseif c==[coordinates1(2,1); coordinates1(1,1)]
    %        edgesCoordinates=[edgesCoordinates; coordinates1];
    %     elseif c==coordinates2 
    %         edgesCoordinates=[edgesCoordinates; coordinates2];
    %     elseif c==[coordinates2(2,1); coordinates2(1,1)]
    %         edgesCoordinates=[edgesCoordinates; coordinates2];
    %     elseif c==coordinates3 
    %         edgesCoordinates=[edgesCoordinates; coordinates3];
    %     elseif c==[coordinates3(2,1); coordinates3(1,1)]
    %         edgesCoordinates=[edgesCoordinates; coordinates3];
    %     end
    % 
    % end

      % Extract the vertices of the specified triangle
    triangleVertices = triangulation.ConnectivityList(nRowNode, :);

    % Initialize list to store real edges found
    realEdges = [];

    % Check each edge of the triangle
    for k = 1:3
        % Get vertex indices for the current edge
        vertex1 = triangleVertices(k);
        vertex2 = triangleVertices(mod(k, 3) + 1);  % Next vertex in the triangle

        % Form the edge as a pair of vertex indices
        edge = sort([vertex1, vertex2]);  % Ensure consistent edge representation
        tr_line=[triangulation.Points(edge(1),:); triangulation.Points(edge(2),:)];

        % Check if this edge exists in map.lines
        for m = 1:size(map.lines, 1)
            line = [map.points(map.lines(m, 1),:) ; map.points(map.lines(m, 2),:)];
            if isequal(line, tr_line) || isequal(line, [tr_line(2,:); tr_line(1,:)])
                % Found a match: store the real edge
                realEdges = [realEdges; edge];
                break;  % No need to check further once a match is found
            end
        end
    end

end
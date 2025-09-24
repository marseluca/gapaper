function virtual_edges=edgesExtraction(map, triangulation)

   %  % Extract edges from the triangulation
   %  triangulationEdges = [];
   %  for i = 1:size(triangulation.ConnectivityList, 1)
   %      % Get indices of the vertices for the current triangle
   %      vertices = triangulation.ConnectivityList(i, :);
   % 
   %      % Generate edges from the vertices (3 edges for a triangle)
   %      edges = [
   %          vertices(1), vertices(2);
   %          vertices(2), vertices(1);
   %          vertices(2), vertices(3);
   %          vertices(3), vertices(2);
   %          vertices(3), vertices(1);
   %          vertices(1), vertices(3);
   %      ];
   % 
   %      % Append to the list of triangulation edges
   %      triangulationEdges = [triangulationEdges; edges];
   %  end
   % 
   %  % Convert triangulationEdges to unique string representation
   % % triangulationEdgeStrings = arrayfun(@(x) sprintf('%d-%d', x(1), x(2)), sort(triangulationEdges, 2), 'UniformOutput', false);
   % 
   %  % Find edges in triangulationEdgeStrings that are not in mapEdgeStrings
   %  virtual_edges_ = setdiff(triangulationEdges, map.lines, 'rows');
   %  sorted=sort(virtual_edges_,2); % now first element is greater than the second
   %  unique_rows=unique(sorted,'rows');
   %  virtual_edges=unique_rows(all(diff(unique_rows,1,2)~=0, 2), :);

    conc_edges=[];
    for i=1:size(triangulation.ConnectivityList,1)
        conc_edges=[conc_edges; triangulation.ConnectivityList(i,1) triangulation.ConnectivityList(i,2); triangulation.ConnectivityList(i,2) triangulation.ConnectivityList(i,3)];
    end


    mapPoints = unique(map.points, 'rows');

    virtual_edges_ = [];
    for i = 1:size(conc_edges, 1)
        % Extract endpoints of the current edge
        edgeEndpoints = conc_edges(i, :);
        
        % Check if both endpoints are not coincident with any map points
        endpoint1 = triangulation.Points(edgeEndpoints(1), :);
        endpoint2 = triangulation.Points(edgeEndpoints(2), :);

        for j=1:size(map.lines,1)
            m1=map.lines(j,1);
            m2=map.lines(j,2);
            mp1=map.points(m1,:);
            mp2=map.points(m2,:);
            if ~ismember(endpoint1, mp1, 'rows') && ~ismember(endpoint1, mp2, 'rows') && ~ismember(endpoint2, mp1, 'rows') && ~ismember(endpoint2, mp2, 'rows')
                virtual_edges_=[virtual_edges_; edgeEndpoints];
            end
        end
        
        % if ~ismember(endpoint1, mapPoints, 'rows') && ~ismember(endpoint2, mapPoints, 'rows')
        %     % Both endpoints are valid, add this edge to validEdges
        %     virtual_edges = [virtual_edges; edgeEndpoints];
        % end
    end
    
    virtual_edges=unique(virtual_edges_,'rows');

end
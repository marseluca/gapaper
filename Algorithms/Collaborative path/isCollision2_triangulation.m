function collision2 = isCollision2_triangulation(node1, node2, triangulation)

    conc_edges_=[];
    conc_edges=[];

    for i=1:size(triangulation.ConnectivityList,1)
        conc_edges_=[conc_edges_; triangulation.ConnectivityList(i,1) triangulation.ConnectivityList(i,2); triangulation.ConnectivityList(i,2) triangulation.ConnectivityList(i,3)];
    end
    
    for i=1:size(conc_edges_,1)
        p1=triangulation.Points(conc_edges_(i,1),:);
        p2=triangulation.Points(conc_edges_(i,2),:);
        if ~isOnSegment(p1,p2,node1) && ~isOnSegment(p1,p2,node2)
            conc_edges=[conc_edges; conc_edges_(i,:)];
        end
    end
    for i = 1:size(conc_edges, 1)
        % Get indices of the start and end points of the current line segment
        idx_st = conc_edges(i, 1);
        idx_e = conc_edges(i, 2);

        % Get coordinates of the start and end points of the current line segment
        point_st = triangulation.Points(idx_st, :);
        point_e = triangulation.Points(idx_e, :);

        % Check for intersection between node1-node2 and point_start-point_end segments
        if segmentsIntersect(node1, node2, point_st, point_e)
            collision2 = true;  % Collision detected
            return;
        else
            collision2 = false;
        end
    end
end

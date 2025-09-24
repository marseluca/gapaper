%% Function to check for collision with map obstacles
function collision1 = isCollision1_triangulation(node1, node2, map)
    % Extract lines and points data from map structure
    lines = map.lines;
    points = map.points;

    % Iterate through each line segment in the map
    for i = 1:size(lines, 1)
        % Get indices of the start and end points of the current line segment
        idx_start = lines(i, 1);
        idx_end = lines(i, 2);

        % Get coordinates of the start and end points of the current line segment
        point_start = points(idx_start, :);
        point_end = points(idx_end, :);

        % Check for intersection between node1-node2 and point_start-point_end segments
        if segmentsIntersect(node1, node2, point_start, point_end)
            collision1 = true;  % Collision detected
            return;
        else
            collision1 = false;
        end
    end

  
    
    
end

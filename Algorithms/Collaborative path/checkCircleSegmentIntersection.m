function intersects = checkCircleSegmentIntersection(P1, P2, circle_radius, map)
    % P1, P2: Endpoints of the segment where the circle's center moves
    % circle_radius: Radius of the circle
    % Q1, Q2: Endpoints of the other segment to check for intersection
    
    % Parameterize the segment P1 to P2
    t_values = linspace(0, 1, 20);  % Adjust the number of points as needed
    centers = P1 +  (P2 - P1).*t_values';  % Calculate circle center positions
    
    % Check for intersection at each center position
    intersects = false;
    for i = 1:length(t_values)
        % Circle center at current position
        center = centers(i, :);
        
        for k = 1:size(map.lines, 1)
            % Extract endpoints of map line segment
            Q1 = map.points(map.lines(k, 1),:);
            Q2 = map.points(map.lines(k, 2),:);
            % Check if the circle centered at 'center' with radius 'circle_radius' intersects with segment Q1-Q2
            if circleSegmentIntersection(center, circle_radius, Q1, Q2)
                intersects = true;
                % disp(intersects);
                break;
            end
        end

        if intersects==true
            % disp(intersects);
            break;
        end
        
    end
end

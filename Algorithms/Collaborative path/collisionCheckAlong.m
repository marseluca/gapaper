function intersects_map_line=collisionCheckAlong(current_point, new_point, safety_margin, map)
    

            point1_ = current_point;
            point2_ = new_point;

            % Now I add the radius+safety margin
            distance=sqrt((point2_(1)-point1_(1))^2 + (point2_(2)-point1_(1))^2);
            point1=[point1_(1)-(safety_margin*(point2_(2)-point1_(2))/distance), point1_(2)+(safety_margin*(point2_(1)-point1_(1))/distance)];
            point2=[point2_(1)-(safety_margin*(point2_(2)-point1_(2))/distance), point2_(2)+(safety_margin*(point2_(1)-point1_(1))/distance)];
            
            % Check if this line segment intersects with any map line
            % intersects_map_line = false;
            for k = 1:size(map.lines, 1)
                % Extract endpoints of map line segment
                map_point1 = map.points(map.lines(k, 1),:);
                map_point2 = map.points(map.lines(k, 2),:);
                
                % Check intersection between the two line segments
                if k+1 <= size(map.lines, 1) && segmentsIntersect(point1, point2, map_point1, map_point2)
                    intersects_map_line = true;
                    break;
                else
                    intersects_map_line=false;
                end
            end
end

    % plot(x_coords, y_coords, 'b-', 'LineWidth', 1.5);  % Customize line properties as needed
    




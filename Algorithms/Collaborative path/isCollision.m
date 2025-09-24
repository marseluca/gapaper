%% Function to check for collision with map obstacles
function collision = isCollision(node1, node2, map, safety_margin)

%     % Extract lines and points data from map structure
%     lines = map.lines;
%     points = map.points;
% 
%     % Iterate through each line segment in the map
%     for i = 1:size(lines, 1)
%         % Get indices of the start and end points of the current line segment
%         idx_start = lines(i, 1);
%         idx_end = lines(i, 2);
% 
%         % Get coordinates of the start and end points of the current line segment
%         point_start = points(idx_start, :);
%         point_end = points(idx_end, :);
% 
% 
       %% Collision along the segment
        collision = checkCircleSegmentIntersection(node1, node2, safety_margin, map);
%         % disp('Intersection check');
%         % disp(intersects_map_line);
% 
% 
%         % for j = 1:size(map.lines, 1)
%             % segment_start = map.points(map.lines(i, 1),:);
%             % segment_end = map.points(map.lines(i, 2),:);
% 
%             % Check intersection between circle and line segment
%             % if circleLineIntersect(safety_margin, node2, safety_margin, segment_start, segment_end)
%             %     collision = true;
%             %     return; 
%             % else
%             %     collision=false;
%             % end
%         % end
% %% 
% 
%         % Check for intersection between node1-node2 and point_start-point_end segments
%         if segmentsIntersect(node1, node2, point_start, point_end)
%             collision = true;  % Collision detected
%             return;
%         else
%             collision = false;
%         end
%     end
% 
%     % No collision detected
%     collision = false;
end

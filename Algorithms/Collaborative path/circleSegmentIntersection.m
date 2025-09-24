function intersects = circleSegmentIntersection(center, radius, Q1, Q2)

 % Check if a circle with given center and radius intersects with a line segment defined by endpoints Q1 and Q2
    
    % Compute the vector representing the segment
    PQ = Q2 - Q1;
    
    % Vector from Q1 to circle center
    V = center - Q1;
    
    % Calculate the dot products
    PQ_V = dot(PQ, V);
    PQ_PQ = dot(PQ, PQ);
    
    % Calculate the parameter t along the line segment
    t = PQ_V / PQ_PQ;
    
    % Clamp t to the interval [0, 1] to get the closest point on the segment
    t = max(0, min(1, t));
    
    % Calculate the closest point C on the segment to the circle center
    closest_point = Q1 + t * PQ;
    
    % Calculate the distance from the circle center to the closest point
    distance = norm(center - closest_point);
    
    % Check if the distance is less than or equal to the circle's radius
    if distance <= radius
        intersects = true;  % Circle intersects with the segment
    else
        intersects = false;  % Circle does not intersect with the segment
    end
    
end

% % Check if the circle with center 'center' and radius 'radius' intersects with segment Q1-Q2
% 
%     % Compute the vector from Q1 to Q2 and its normal
%     PQ = Q2 - Q1;
%     PQ_norm = PQ / norm(PQ);
% 
%     % Compute the projection of 'center' onto the line containing segment Q1-Q2
%     projection = Q1 + dot(center - Q1, PQ_norm) * PQ_norm;
% 
%     % Compute the distance from 'center' to the projection
%     distance = norm(center - projection);
% 
%     % Check if the distance is less than or equal to the circle radius
%     intersects = (distance <= radius);
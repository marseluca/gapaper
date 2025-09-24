function intersects = circleLineIntersect(safety_margin, circleCenter, radius, segmentStart, segmentEnd)
    % Compute vector components
    v = segmentEnd - segmentStart;
    w = circleCenter - segmentStart;
    
    % Compute projection parameter of point closest to circle center on the line
    c = dot(w, v) / dot(v, v);
    
    % Clamp parameter c to [0,1] to get the closest point on the segment
    c = max(0, min(c, 1));
    
    % Compute closest point on the line segment
    closest_point = segmentStart + c * v;
    
    sum=radius+safety_margin;
    % Check if the closest point is within the circle
    distance = norm(circleCenter - closest_point);
    intersects = (distance <= sum);
end
function onSegment = isOnSegment(p, q, r)
    % Verify if the point r is on the segment p-q

    if (min(p(1), q(1)) <= r(1) && r(1) <= max(p(1), q(1))) && (min(p(2), q(2)) <= r(2) && r(2) <= max(p(2), q(2)))
        onSegment = true;
    else
        onSegment = false;
    end
end
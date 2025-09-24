%% Computation of the cross product
function result = cross2d(u, v)
    % Compute cross product of 2D vectors (u x v)
    result = u(1) * v(2) - u(2) * v(1);
end

function randomPoint = randomPoint_triangulation(max_x, min_x, max_y, min_y, middle_points, middle_done)
    keep = ~ismember(middle_points, middle_done, 'rows');
    result = middle_points(keep, :);

    disp(size(result,1));

    filtered_points = result(...
    result(:, 1) >= min_x & result(:, 1) <= max_x & ...
    result(:, 2) >= min_y & result(:, 2) <= max_y, :);

    if ~isempty(filtered_points)
        random_index = randi(size(filtered_points, 1));
        randomPoint = filtered_points(random_index, :);
    else
        disp('No point found in the specified range.');
    end


end
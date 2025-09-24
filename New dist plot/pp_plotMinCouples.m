function pp_plotMinCouples(trajectories)

    global nRobots delta_s;

    [minDistances, closestPairs] = pp_getMinimumDistances2(trajectories);
    

    [~, maxLengthIndex] = max(arrayfun(@(i) length(trajectories{i}.x_tot), 1:nRobots));
    maxTimeStep = length(minDistances);
    timeSteps = trajectories{maxLengthIndex}.t_tot(1:maxTimeStep);

    figure
    plot(timeSteps,minDistances,'-')
    hold on; grid on;
    safetyLine = plot(timeSteps, delta_s * ones(1, length(minDistances)), ':', 'Color', 'k', 'LineWidth', 1.2, 'DisplayName', 'Safety margin');
    xlabel('t [s]');
    ylabel("$d(t)\:[m]$",'Interpreter','latex')
    title('Minimum distance between robots');
    
    % Initialize a colormap and a map to track colors
    pairColors = containers.Map();
    uniquePairs = {};
    colorMap = lines(10); % Up to 10 unique colors
    colorIndex = 1;

    % Start with the first pair
    startIdx = 1;
    currentPair = '';
    
    % Iterate through all time steps
    for i = 1:length(closestPairs)
        % Skip empty cells
        if isempty(closestPairs{i})
            continue;
        end
        
        % Format the current pair as a string
        newPair = sprintf('R%d-R%d', closestPairs{i}(1), closestPairs{i}(2));
        
        % Assign a color if the pair is not already mapped
        if ~isKey(pairColors, newPair)
            pairColors(newPair) = colorMap(colorIndex, :);
            uniquePairs{end+1} = newPair;
            colorIndex = mod(colorIndex, size(colorMap, 1)) + 1;
        end
        
        % When the pair changes, plot the previous segment
        if ~strcmp(currentPair, newPair) && ~isempty(currentPair)
            endIdx = i - 1;
            
            % Plot the line segment for the previous pair
            plot(timeSteps(startIdx:endIdx), minDistances(startIdx:endIdx), ...
                '-', 'Color', pairColors(currentPair), 'LineWidth', 2.5);
            
            startIdx = i; % Update start index
        end
        
        % Update the current pair
        currentPair = newPair;
    end

    % Explicitly handle the **last segment** after the loop
    if ~isempty(currentPair)
        endIdx = length(timeSteps);
        
        % Ensure the last pair has a color
        if ~isKey(pairColors, currentPair)
            pairColors(currentPair) = colorMap(colorIndex, :);
            uniquePairs{end+1} = currentPair;
        end
        
        plot(timeSteps(startIdx:endIdx), minDistances(startIdx:endIdx), ...
            '-', 'Color', pairColors(currentPair), 'LineWidth', 2.5);
    end

    % Add a legend for the pairs
    legendEntries = cell(length(uniquePairs), 1);
    legendHandles = gobjects(length(uniquePairs), 1);

    for i = 1:length(uniquePairs)
        pairKey = uniquePairs{i};
        legendHandles(i) = plot(NaN, NaN, '-', ...
            'Color', pairColors(pairKey), ...
            'LineWidth', 1.5, ...
            'DisplayName', pairKey);
        legendEntries{i} = pairKey;
    end

    legend([legendHandles; safetyLine], [legendEntries; {'Safety margin'}], 'Location', 'best');

    ylim([0 Inf]);
    hold off;
end
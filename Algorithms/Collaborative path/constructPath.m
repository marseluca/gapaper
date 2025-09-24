%% Function to construct path from goal to start using backtracking
function path = constructPath(goalNode, parentNodeMap, nodes, lines)
    % Initialize path as empty
    path = [];

    % Trace back from goalNode to startNode using parent pointers
    currentNode = goalNode;
    while ~isempty(currentNode)
        % Prepend current node to the path
        path = [currentNode; path];

        % Check if currentNode has a parent
        if isfield(parentNodeMap, num2str(currentNode))
            % Move to the parent node
            currentNode = parentNodeMap.(num2str(currentNode));
        else
            % No parent node (reached the start node)
            currentNode = [];
        end
    end

    % Plot the tree and path
    % figure;
    hold on;
    title('RRT*');

    % Plot tree edges (lines between nodes)
    for i = 1:size(lines, 1)
        idx_start = lines(i, 1);
        idx_end = lines(i, 2);
        startNode = nodes(idx_start, :);
        endNode = nodes(idx_end, :);
        plot([startNode(1), endNode(1)], [startNode(2), endNode(2)], 'b-');
    end
    
    hold on;
    % Highlight path on the tree
    for i = 1:length(path)-1
        node1 = nodes(path(i), :);
        node2 = nodes(path(i+1), :);
        plot([node1(1), node2(1)], [node1(2), node2(2)], 'r', 'LineWidth', 2);
    end
    
    hold on;
    % Mark start and goal nodes
    startNode = nodes(path(1), :);
    goalNode = nodes(path(end), :);
    plot(startNode(1), startNode(2), 'go', 'MarkerSize', 8, 'LineWidth', 2);
    plot(goalNode(1), goalNode(2), 'ro', 'MarkerSize', 8, 'LineWidth', 2);

    % Set axis properties
    axis equal;
    title('Tree and Path Visualization');
    xlabel('X');
    ylabel('Y');
    legend('Tree Edges', 'Path', 'Start Node', 'Goal Node');
    hold off;
end
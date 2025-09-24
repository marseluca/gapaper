function [allPaths, all_paths_lenght] = dfs(adjMatrix, currentNode, goalNode, visited, currentPath, allPaths, cont, all_paths_lenght)
    
    % Base case: if we reach the goal node, add the current path to allPaths
    if currentNode == goalNode
        allPaths{end+1} = currentPath;
        all_paths_lenght=[all_paths_lenght; size(currentPath,2)];
        return;
    end
    
    % Recursively visit all adjacent nodes
    for neighbor = find(adjMatrix(currentNode, :)==1)
        if ~visited(neighbor)
            % Mark the neighbor as visited
            visited(neighbor) = true;
            
            % Recursive call to continue the path
            [allPaths, all_paths_lenght] = dfs(adjMatrix, neighbor, goalNode, visited, [currentPath, neighbor], allPaths, cont, all_paths_lenght);
            cont=cont+1;
            disp(cont);
            % Unmark the neighbor as visited (backtracking)
            visited(neighbor) = false;
        end
    end
end
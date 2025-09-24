function [allPaths, all_paths_lenght] = findAllPaths(adjMatrix, nRowStart, nRowGoal, cont, all_paths_lenght)
    % Initialize variables
    numTriangles = size(adjMatrix, 1);
    allPaths = {};
    
    % Initialize the visited array
    visited = false(numTriangles, 1);
    
    % Start the DFS from the start triangle
    currentPath = nRowStart;
    visited(nRowStart) = true;
    [allPaths, all_paths_lenght] = dfs(adjMatrix, nRowStart, nRowGoal, visited, currentPath, allPaths, cont, all_paths_lenght);
end
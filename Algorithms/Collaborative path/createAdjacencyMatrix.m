function adjMatrix = createAdjacencyMatrix(triangulation, map)
    % Numero di triangoli nella triangolazione
    numTriangles = size(triangulation.ConnectivityList, 1);
    
    % Inizializza la matrice di adiacenza
    adjMatrix = zeros(numTriangles, numTriangles);
    
    % Per ogni coppia di triangoli, verifica l'adiacenza e l'intersezione con la mappa
    for i = 1:numTriangles
        tri1 = triangulation.ConnectivityList(i, :);
        % disp(tri1);
        n1=findTriangleContainingEdge_brute_force(triangulation.ConnectivityList, [tri1(1) tri1(2)], i);
        n2=findTriangleContainingEdge_brute_force(triangulation.ConnectivityList, [tri1(2) tri1(3)], i);
        n3=findTriangleContainingEdge_brute_force(triangulation.ConnectivityList, [tri1(1) tri1(3)], i);
        n=[n1; n2; n3];
        % disp(n);
        for j = 1:numTriangles
            real=size(findRealEdges(j, triangulation, map),1);
            if i ~= j
                tri2 = triangulation.ConnectivityList(j, :);
                if j==n(1)
                    disp('1');
                    if intersectsMap(triangulation, tri2, map) || real>1
                        adjMatrix(i, j) = 2;
                    else
                        disp('__________________');
                        adjMatrix(i, j) = 1;
                    end
                elseif j==n(2)
                    disp('2');
                    if intersectsMap(triangulation, tri2, map) || real>1
                        adjMatrix(i, j) = 2;
                    else
                        disp('__________________');
                        adjMatrix(i, j) = 1;
                    end
                elseif j==n(3)
                    disp('3');
                    if intersectsMap(triangulation, tri2, map) || real>1
                        adjMatrix(i, j) = 2; 
                    else
                        disp('__________________');
                        adjMatrix(i, j) = 1;
                    end
                end
            end
        end
    end
end
function edges = buildEdges(triangulation, map)
    % Costruisce gli archi del grafo dai dati della triangolazione
    numTriangles = size(triangulation.ConnectivityList, 1);
    edges = cell(numTriangles, 1);
    
    % Per ogni triangolo, trova i triangoli adiacenti che non intersecano gli ostacoli
    for i = 1:numTriangles
        currentTri = triangulation.ConnectivityList(i, :);
        for j = 1:numTriangles
            if i ~= j
                neighborTri = triangulation.ConnectivityList(j, :);
                if isAdjacent(currentTri, neighborTri) && ~intersectsObstacles(triangulation, currentTri, neighborTri, map)
                    edges{i} = [edges{i}, j];
                end
            end
        end
    end
end
    
    % for i=1:numTriangles
    %     edge1=[triangulation.ConnectivityList(i,1) triangulation.ConnectivityList(i,2)];
    %     edge2=[triangulation.ConnectivityList(i,2) triangulation.ConnectivityList(i,3)];
    %     edge3=[triangulation.ConnectivityList(i,1) triangulation.ConnectivityList(i,3)];
    % 
    %     t1=findTriangleContainingEdge_brute_force(triangulation.ConnectivityList, edge1);
    %     t2=findTriangleContainingEdge_brute_force(triangulation.ConnectivityList, edge2);
    %     t3=findTriangleContainingEdge_brute_force(triangulation.ConnectivityList, edge3);
    % 
    %     t=[t1; t2; t3];
    % 
    %     intersection=false;
    %     for j=1:3
    %         for z=1:size(map.lines,1)
    %             if segmentsIntersect(triangulation.Points(triangulation.ConnectivityList(t(j),1)), triangulation.Points(triangulation.ConnectivityList(t(j),2)), map.points(map.lines(z,1)), map.points(map.lines(z,2)))
    %                 intersection=true;
    %                 break;
    %             elseif segmentsIntersect(triangulation.Points(triangulation.ConnectivityList(t(j),2)), triangulation.Points(triangulation.ConnectivityList(t(j),3)), map.points(map.lines(z,1)), map.points(map.lines(z,2)))
    %                 intersection=true;
    %                 break;
    %             elseif segmentsIntersect(triangulation.Points(triangulation.ConnectivityList(t(j),1)), triangulation.Points(triangulation.ConnectivityList(t(j),3)), map.points(map.lines(z,1)), map.points(map.lines(z,2)))
    %                 intersection=true;
    %                 break;
    %             end
    %         end
    %         if intersection==true
    %             break;
    %         else
    %             edges{i} = [edges{i}, t(j)];
    %         end
    %     end
    % end
    % 
    % 
    % 

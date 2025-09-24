function nRow=whichTriangle(node_coord, triangulation)

    for i=1:size(triangulation.ConnectivityList,1)
        
        p=[];
        for j=1:3
            p=[p; triangulation.Points(triangulation.ConnectivityList(i,j),:)];
        end
        
        if inpolygon(node_coord(1), node_coord(2), p(:,1), p(:,2))
            nRow=i;
            return;
        end
        
    end

end
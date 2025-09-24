function intersects = intersectsMap(triangulation, tri, map)
    intersects = false;
    flag=false;
    triang_n_edges=[tri(1) tri(2); tri(2) tri(3); tri(1) tri(3)];
    for i=1:size(map.lines,1)
        for j=1:size(triang_n_edges,1)
            if segmentsIntersect(map.points(map.lines(i,1),:), map.points(map.lines(i,2),:), triangulation.Points(triang_n_edges(j,1),:), triangulation.Points(triang_n_edges(j,2),:))
                intersects=false;
                flag=true;
                break;
            end
        end
        if flag==true
            break;
        end
    end
end
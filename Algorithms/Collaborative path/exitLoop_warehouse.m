function [currentTriangleIndex, order, adjacentTriangles] =  exitLoop(nRowStart, visited_order, triangulation, map, visitedTriangles, adjacentTriangles)
    % v_order=visited_order;
    v_order_=visited_order(1:end);
    currentTriangleIndex=v_order_(end);

    v_order_minus_one=visited_order(1:end);
    s=size(v_order_minus_one,1);

    ok=false;
    
    for i=s:-1:1
        if s==1
           disp('Failed')
        end

        realEdgesTriangle=findRealEdges(v_order_minus_one(i), triangulation, map);
        virtualEdgesTriangle=findVirtualEdges(v_order_minus_one(i), triangulation, realEdgesTriangle);
        n_=[];
        for j=1:size(virtualEdgesTriangle,1)
            n=findTriangleContainingEdge(triangulation.ConnectivityList,virtualEdgesTriangle(j,:),visitedTriangles);
            n_=[n_; n];
        end
        disp(n_);
        index_non_zero_element = find(n_ ~= 0, 1);
        nn=n_(index_non_zero_element);
        if isempty(index_non_zero_element)  
            ok=false;
            if size(v_order_,1)==1 && v_order_(1)==nRowStart
                % order=v_order_;
                break;
            end
            v_order_= v_order_(1:end-1);
            disp(v_order_);
        elseif size(findRealEdges(nn, triangulation, map))>1
            ok=false;
            if size(v_order_,1)==1 && v_order_(1)==nRowStart
                % order=v_order_;
                break;
            end
            v_order_= v_order_(1:end-1);
            disp(v_order_);
        else
            currentTriangleIndex=v_order_minus_one(i);
            ok=true;
            if size(v_order_,1)==1 && v_order_(1)==nRowStart
                % order=v_order_;
                break;
            end
            break;
        end
    end

    adjacentTriangle=nn;
    % if size(findRealEdges(adjacentTriangle,triangulation, map),1)>1
    %     disp('Entering again');
    %     [currentTriangleIndex, v_order_, adjacentTriangles] =  exitLoop(v_order_, triangulation, map, visitedTriangles, adjacentTriangles);
    %     disp('Exiting again');
    %     adjacentTriangles = [adjacentTriangles; adjacentTriangle];
    %     v_order_=[v_order_; adjacentTriangles];
    %     disp(v_order_);
    % else
        adjacentTriangles = [adjacentTriangles; adjacentTriangle];
        v_order_=[v_order_; adjacentTriangles];
        disp(v_order_);
    % end
    
  
    order=v_order_;
    

end

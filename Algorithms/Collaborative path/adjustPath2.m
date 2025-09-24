function new_points_sequence=adjustPath2(sequence, safety_margin, map)
    new_points_sequence=[];
 
    continuee=true;
    i=1;
    while continuee==true
        jump=2;
        for j=i+2:1:size(sequence,1)
            possible_intersection=checkCircleSegmentIntersection(sequence(i,:), sequence(j,:), safety_margin, map);
            if possible_intersection==false
                if j==size(sequence,1)
                    new_points_sequence=[new_points_sequence; sequence(i,:); sequence(j,:)];
                    continuee=false;
                    break;
                end
                jump=jump+1;
            else
                new_points_sequence=[new_points_sequence; sequence(i,:); sequence(i+jump-1,:)];
                i=i+jump-1;
                break;
            end
        end
    end
    




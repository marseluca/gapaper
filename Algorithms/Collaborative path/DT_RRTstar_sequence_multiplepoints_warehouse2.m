close all
clear all
clear figure

mappp.points=[];

mappp.lines=[];

mapp = import_data_catia_vrml('warehouse2.wrl');

for i=1:size(mapp.points,2)
    if mapp.points(1,i)==-0.04
        mappp.points=[mappp.points; mapp.points(2,i) mapp.points(3,i)]; % to put in vertical
    end
end

map.points=unique(mappp.points,'rows'); % to select the unique points

for i=1:size(mapp.lines,2)
    if mapp.points(1,mapp.lines(1,i))==-0.04 && mapp.points(1,mapp.lines(2,i))==-0.04
        x1=mapp.points(2,mapp.lines(1,i)); 
        y1=mapp.points(3,mapp.lines(1,i));
        x2=mapp.points(2,mapp.lines(2,i)); 
        y2=mapp.points(3,mapp.lines(2,i));
        for j=1:size(map.points,1)
            if x1==map.points(j,1) && y1==map.points(j,2) 
                jj=j;
            elseif x1==map.points(j,2) && y1==map.points(j,1)
                jj=j;
            end
        end
        for z=1:size(map.points,1)
            if x2==map.points(z,1) && y2==map.points(z,2) 
                zz=z;
            elseif x2==map.points(z,2) && y2==map.points(z,1)
                zz=z;
            end
        end
        mappp.lines=[mappp.lines; jj zz];

    end
end
% map.lines=unique(mappp.lines, 'rows');
map.lines=mappp.lines;

max_x=max(map.points(:,1));
min_x=min(map.points(:,1));

max_y=max(map.points(:,2));
min_y=min(map.points(:,2));

%% Triangulation

% outerprofile=[];
% innerprofile=[];
% rows_to_exclude=[];
% rows_to_keep=[];
% 
% 
% outerprofile_=[1; 2; 180; 180; 80; 80]; %indices
% for i=1:size(outerprofile_,1)
%     outerprofile=[outerprofile; map.points(outerprofile_(i,1),1:2)]; %coordinates of points
% end
% 
% for i=1:size(outerprofile,1)
%     for j=1:size(map.lines,1)
%         if outerprofile(i,1)==map.lines(j,1) || outerprofile(i,1)==map.lines(j,2) || outerprofile(i,2)==map.lines(j,1) || outerprofile(i,2)==map.lines(j,2)
%             rows_to_exclude=[rows_to_exclude; j];
%         end
%     end
% end
% 
% rows_to_keep = setdiff(1:size(map.lines, 1), rows_to_exclude);
% innerprofile_ = map.lines(rows_to_keep, :);
% for i=1:size(innerprofile_,1)
%     innerprofile=[innerprofile; map.points(innerprofile_(i,1),1:2)];
%     innerprofile=[innerprofile; map.points(innerprofile_(i,2),1:2)];
% end
% outerprofile__=unique(outerprofile,'rows'); %coordinates
% innerprofile__=unique(innerprofile,'rows'); %coordinates
% 
% P=[outerprofile__;innerprofile__];
% % innerc1=[10 9; 9 14; 14 13; 13 7; 7 8; 8 10];
% % innerc2=[6 12; 12 11; 11 5; 5 6];
% % innerc3=[16 18; 18 17; 17 15; 15 16];
% % innerc4=[20 22; 22 21; 21 19; 19 20];
% % %innerc=[8 7; 7 12; 12 11; 11 5; 5 6; 6 8; 4 10; 10 9; 9 3; 3 4; 4 10; 14 16; 16 15; 15 13; 13 14; 18 20; 20 19; 19 17; 17 18];
% % outerc=[4 24; 24 23; 23 3; 3 4];
% innerc1=[18 36; 36 35; 35 17; 17 18];
% innerc2=[52 71; 71 70; 70 51; 51 52];
% innerc3=[16 34; 34 33; 33 15; 15 16];
% innerc4=[50 69; 69 68; 68 49; 49 50];
% 
% innerc5=[14 32; 32 31; 31 13; 13 14];
% innerc6=[48 67; 67 66; 66 47; 47 48];
% innerc7=[22 30; 30 29; 29 21; 21 22];
% innerc8=[20 28; 28 27; 27 19; 19 20];
% 
% innerc9=[42 50; 50 49; 49 41; 41 42];
% innerc10=[40 48; 48 47; 47 39; 39 40];
% innerc11=[38 46; 46 45; 45 37; 37 38];
% innerc12=[36 44; 44 43; 43 35; 35 36];
% 
% 
% %innerc=[8 7; 7 12; 12 11; 11 5; 5 6; 6 8; 4 10; 10 9; 9 3; 3 4; 4 10; 14 16; 16 15; 15 13; 13 14; 18 20; 20 19; 19 17; 17 18];
% outerc=[1 2; 2 180; 180 180; 180 85; 85 86; 86 1];
% C=[outerc; innerc1; innerc2; innerc3; innerc4; innerc5; innerc6; innerc7; innerc8; innerc9; innerc10; innerc11; innerc12];

% Triangulation
triangulation = delaunayTriangulation(map.points);

%% Uncomment the following line to show triangulation
triplot(triangulation);
hold on;
plot(map.points(:,1), map.points(:,2), 'go');
for i=1:size(map.points,1)
    text(map.points(i,1),map.points(i,2),num2str(i),'Color','red');
end

for i=1:size(map.lines,1)
    x1=map.points(map.lines(i,1),1);
    y1=map.points(map.lines(i,1),2);
    x2=map.points(map.lines(i,2),1);
    y2=map.points(map.lines(i,2),2);

    x=[x1 x2];
    y=[y1 y2];
    hold on;
    plot(x, y, '-r','LineWidth',2);
end

mmap.points=unique(map.points,'rows');

% 
% for i=1:size(triangulation.Points,1)
%     text(triangulation.Points(i,1),triangulation.Points(i,2),num2str(i),'Color','red');
% end

hold on 
% plot(triangulation.Points(innerc1',1),triangulation.Points(innerc1',2), ...
%      '-r','LineWidth',2)  
% plot(triangulation.Points(innerc2',1),triangulation.Points(innerc2',2), ...
%      '-r','LineWidth',2) 
% plot(triangulation.Points(innerc3',1),triangulation.Points(innerc3',2), ...
%      '-r','LineWidth',2) 
% plot(triangulation.Points(innerc4',1),triangulation.Points(innerc4',2), ...
%      '-r','LineWidth',2) 
% plot(triangulation.Points(innerc5',1),triangulation.Points(innerc5',2), ...
%      '-r','LineWidth',2)
% plot(triangulation.Points(innerc6',1),triangulation.Points(innerc6',2), ...
%      '-r','LineWidth',2)
% plot(triangulation.Points(innerc7',1),triangulation.Points(innerc7',2), ...
%      '-r','LineWidth',2)
% plot(triangulation.Points(innerc8',1),triangulation.Points(innerc8',2), ...
%      '-r','LineWidth',2)
% plot(triangulation.Points(innerc9',1),triangulation.Points(innerc9',2), ...
%      '-r','LineWidth',2)
% plot(triangulation.Points(innerc10',1),triangulation.Points(innerc10',2), ...
%      '-r','LineWidth',2)
% plot(triangulation.Points(innerc11',1),triangulation.Points(innerc11',2), ...
%      '-r','LineWidth',2)
% plot(triangulation.Points(innerc12',1),triangulation.Points(innerc12',2), ...
%      '-r','LineWidth',2)
% 
% plot(triangulation.Points(outerc',1),triangulation.Points(outerc',2), ...
%      '-r','LineWidth',2)
% axis equal 


%% Writing the number of the triangle in each triangle
P=triangulation.Points;
T=triangulation.ConnectivityList;

vertices1 = P(T(:,1), :);
vertices2 = P(T(:,2), :);
vertices3 = P(T(:,3), :);

triangle_centers = (vertices1 + vertices2 + vertices3) / 3;

num_triangles = size(T, 1);

for i = 1:num_triangles
    % Get the center of the current triangle
    center = triangle_centers(i, :);

    % Display the triangle index at the center
    text(center(1), center(2), num2str(i), 'HorizontalAlignment', 'center');
end


%%
% 
% To remove points inside the boundaries
% hold on;
% TF = isInterior(triangulation);
% triplot(triangulation.ConnectivityList(TF,:),triangulation.Points(:,1),triangulation.Points(:,2))  
% hold on
% % plot(triangulation.Points(outercons',1),triangulation.Points(outercons',2), ...
% %      '-r','LineWidth',2)
% %plot(triangulation.Points(innerc1',1),triangulation.Points(innerc2',1),triangulation.Points(innerc3',1),triangulation.Points(innerc4',1),triangulation.Points(innerc1',2),triangulation.Points(innerc2',2),triangulation.Points(innerc3',2),triangulation.Points(innerc4',2), ...
% %     '-r','LineWidth',2) 
% axis equal;

% List of the triangulation edges that are not real edges
% virtual_edges=edgesExtraction(map, triangulation);

conc_edges_=[];
    for i=1:size(triangulation.ConnectivityList,1)
        conc_edges_=[conc_edges_; triangulation.ConnectivityList(i,1) triangulation.ConnectivityList(i,2); triangulation.ConnectivityList(i,2) triangulation.ConnectivityList(i,3)];
    end
    conc_edges=unique(conc_edges_,'rows');




%% 
% Define start and goal points
startNode = [-0.3, 0.2];
goalNode = [0.3, 0.45];

%%
 % for f=1:3
%%


%% Main loop

nRowStart=whichTriangle(startNode, triangulation); %first input is a coordinate (x and y)
nRowGoal=whichTriangle(goalNode, triangulation);

queue = nRowStart;
visitedTriangles = false(size(triangulation.ConnectivityList, 1), 1);
visitedTriangles(nRowStart) = true;
visited_order=[nRowStart];
cont=0;

first_triangle_edges=[triangulation.ConnectivityList(nRowStart,1) triangulation.ConnectivityList(nRowStart,2); triangulation.ConnectivityList(nRowStart,2) triangulation.ConnectivityList(nRowStart,3); triangulation.ConnectivityList(nRowStart,1) triangulation.ConnectivityList(nRowStart,3)];

first_triangle_adj_triangles=[];
for i=1:size(first_triangle_edges,1)
    m=findTriangleContainingEdge(triangulation.ConnectivityList, first_triangle_edges(i,:), visitedTriangles);
    first_triangle_adj_triangles=[first_triangle_adj_triangles; m];
end

realEdgesStart=findRealEdges(nRowStart, triangulation, map);
virtualEdgesStart=findVirtualEdges(nRowStart, triangulation, realEdgesStart);

loop=false;

while ~isempty(queue)

        number_of_n=0;
        flag=false;
        currentTriangleIndex = queue(1);
        queue(1) = [];

        if currentTriangleIndex == nRowGoal
            disp('Goal reached');
            reconstructPath(triangulation, visited_order);
            break;  
        end

        realEdges=findRealEdges(currentTriangleIndex, triangulation, map);
        virtualEdges=findVirtualEdges(currentTriangleIndex, triangulation, realEdges);

        adjacentTriangles=[];

        bueno=false;
        chosen=0;
        all_vertices=0;

        if cont~=0
            previous_vertices=triangulation.ConnectivityList(visited_order(end-1),:);
            while bueno==false
                random_number = randi([1, size(virtualEdges,1)]);
                all_vertices=all_vertices+1;
                if ~any(ismember(chosen, random_number,"rows"))
                    chosen=[chosen; random_number];
                    n=findTriangleContainingEdge(triangulation.ConnectivityList, virtualEdges(random_number,:), visitedTriangles);
                    disp('N:');
                    disp(n);
                    if n>0 && size(findRealEdges(n,triangulation, map),1)<=1
                        triang_n_edges=[triangulation.ConnectivityList(n,1) triangulation.ConnectivityList(n,2); triangulation.ConnectivityList(n,2) triangulation.ConnectivityList(n,3); triangulation.ConnectivityList(n,1) triangulation.ConnectivityList(n,3)];
                        for i=1:size(map.lines,1)
                            for j=1:size(triang_n_edges,1)
                                if segmentsIntersect(map.points(map.lines(i,1),:), map.points(map.lines(i,2),:), triangulation.Points(triang_n_edges(j,1),:), triangulation.Points(triang_n_edges(j,2),:))
                                    bueno=false;
                                    flag=true;
                                    break;
                                end
                            end
                            if flag==true
                                break;
                            end
                        end

                        if flag==false
                        if any(ismember(previous_vertices, virtualEdges(random_number,1))) && any(ismember(previous_vertices, virtualEdges(random_number,2)))
                            bueno=false;
                        % elseif size(findRealEdges(n,triangulation, map),1)>1
                        %     bueno=false;
                        else
                            bueno=true;
                            adjacentTriangle=n;
                            if adjacentTriangle>0
                                adjacentTriangles = [adjacentTriangles; adjacentTriangle];
                                visited_order=[visited_order; adjacentTriangle];
                            end
                        end
                        end
                    elseif n>0 && size(findRealEdges(n,triangulation, map),1)>1
                        % visitedTriangles(n) = true;
                         number_of_n=number_of_n+1;
                    else 
                        number_of_n=number_of_n+1;
                    end
                    if number_of_n>0
                        disp('Entering exitLoop');
                        disp(visited_order);
                        [currentTriangleIndex, visited_order, adjacentTriangles] =  exitLoop_warehouse(nRowStart, visited_order, triangulation, map, visitedTriangles, adjacentTriangles);
                        disp('Exiting exitLoop');
                        disp(visited_order);
                        bueno=true;
                        % number_of_n=0;
                    end
                end
            end
            % if loop==true
            %     [currentTriangleIndex, v_order_, adjacentTriangles] =  exitLoop(visited_order, triangulation, map, first_triangle_edges, visitedTriangles, currentTriangleIndex, adjacentTriangles);
            % end
        else
            random_number = randi([1, size(virtualEdges,1)]);
            adjacentTriangle=findTriangleContainingEdge(triangulation.ConnectivityList, virtualEdges(random_number,:), visitedTriangles);
            if adjacentTriangle>0
               adjacentTriangles = [adjacentTriangles; adjacentTriangle];
               visited_order=[visited_order; adjacentTriangle];
            end

        end

        queue = [queue; adjacentTriangles];
        visitedTriangles(adjacentTriangles) = true;

        cont=cont+1;
end

% %% Initialization
% 
% num_samples = 6; 
% 
% samples = struct('rows', [], 'points', [], 'points_', []);
% 
% circle_radius = 0.003; 
% safety_margin = circle_radius + circle_radius*0.05; %+il 5%
% 
% 
% 
% %% Placing the samples on the edges
% for i = 1:numel(visited_order) - 1
% 
%     triangle1_idx = visited_order(i);
%     triangle2_idx = visited_order(i + 1);
% 
%     % Get the vertices (points) of each triangle
%     vertices1 = triangulation.Points(triangulation.ConnectivityList(triangle1_idx, :), :);
%     vertices2 = triangulation.Points(triangulation.ConnectivityList(triangle2_idx, :), :);
% 
%     % Identify common vertices between the two triangles
%     common_vertices = intersect(triangulation.ConnectivityList(triangle1_idx, :), triangulation.ConnectivityList(triangle2_idx, :));
% 
%     % Check if there are exactly two common vertices (one shared edge)
%     if numel(common_vertices) ~= 2
%         error('Unexpected number of common vertices between triangles.');
%     end
% 
%     % Determine the indices of the common vertices within each triangle
%     common_vertex_indices1 = find(ismember(triangulation.ConnectivityList(triangle1_idx, :), common_vertices));
%     common_vertex_indices2 = find(ismember(triangulation.ConnectivityList(triangle2_idx, :), common_vertices));
% 
%     % Get the common vertices from each triangle
%     common_vertex1 = vertices1(common_vertex_indices1, :);
%     common_vertex2 = vertices2(common_vertex_indices2, :);
% 
%     % Calculate equidistant samples along the edge connecting common vertices
%     t = linspace(0, 1, num_samples + 2)';  % Equally spaced parameter values
%     t = t(2:end-1);  % Exclude the endpoints (0 and 1)
% 
%     % Check dimensions of common_vertex1 and common_vertex2
%     if size(common_vertex1, 1) ~= size(common_vertex2, 1)
%         error('Common vertices have incompatible dimensions.');
%     end
% 
%     t = t(:);  % Force t to be a column vector
% 
%     % Calculate edge_samples using element-wise operations
%     edge_samples = common_vertex1(1,:) + t.* (common_vertex1(2,:) - common_vertex1(1,:));
% 
%     % Get the other vertices (not part of the common edge) for each triangle
%     other_vertices1 = vertices1(~ismember(1:size(vertices1, 1), common_vertex_indices1), :);
%     other_vertices2 = vertices2(~ismember(1:size(vertices2, 1), common_vertex_indices2), :);
% 
%     % Append the data to the samples structure
%     edge_indices = repmat(common_vertex_indices1, numel(t), 1);  % Repeated indices for the common edge
%     edge_points = [edge_samples; other_vertices1; other_vertices2];
% 
%     samples.rows = [samples.rows; common_vertices];
%     samples.points_ = [samples.points_; edge_points];
% end
% 
% [~, idx_to_remove] = ismember(samples.points_, triangulation.Points, "rows");
% 
% filtered_points = samples.points_(all(idx_to_remove == 0, 2), :);
% 
% samples.points=filtered_points;
% 
% hold on;
% for i = 1:size(samples.points, 1)
%     % Edge's center
%     x_center = samples.points(i, 1);
%     y_center = samples.points(i, 2);
% 
%     % Draw circle on the edge
%     theta = linspace(0, 2*pi, 100); 
%     x_circle = x_center + circle_radius * cos(theta);
%     y_circle = y_center + circle_radius * sin(theta);
%     %plot(x_circle, y_circle, 'r');
% end
% 
% %% Generating path
% 
% for b=1:3
%     disp('Path number');
%     disp(b);
% 
%     hold on;
%     points_sequence = [startNode];
%     current_point = startNode;
% 
% 
%     stop=false;
%     for i = 1:num_samples:size(samples.points, 1)-num_samples+1
%         disp('i:');
%         disp(i);
%         disp('---------------------');
%         random_index_taken=[];
%         contin=true;
%         another_random=false;
% 
%         while contin
%             if size(random_index_taken,1)>=num_samples
%                 disp('Failed to find a collision-free connection :(');
%                 stop=true;
%                 % contin=false;
%                 break;
%             end
%             random_index = randi([i, i + num_samples - 1]);
%             disp('Random index:');
%             disp(random_index);
%             if ~ismember(random_index, random_index_taken)
%                 random_index_taken=[random_index_taken; random_index];
%                 new_point = samples.points(random_index, :);
%                 another_random=false;
%             else 
%                 disp('Random index already taken, trying with another one');
%                 another_random=true;
%             end
% 
%             % intersects_map_line=collisionCheckAlong(current_point, new_point, safety_margin, map);
% 
%             if another_random==false
%                 intersects_map_line = checkCircleSegmentIntersection(current_point, new_point, safety_margin, map);
%                 disp('Intersection check');
%                 disp(intersects_map_line);
% 
%                 circle_ok=false;
%                 for j = 1:size(map.lines, 1)
%                     segment_start = map.points(map.lines(j, 1),:);
%                     segment_end = map.points(map.lines(j, 2),:);
% 
%                     % Check intersection between circle and line segment
%                     if circleLineIntersect(safety_margin, new_point, circle_radius, segment_start, segment_end)
%                         circle_ok = false;
%                         break; 
%                     end
%                  end
% 
%                 if ~intersects_map_line
% 
%                     contin=false;
%                     current_point = new_point;
%                     points_sequence = [points_sequence; new_point];
% 
%                 else
%                     contin=true;
%                 end
%                 % disp(contin);
% 
%             end
%         end
%         if stop==true
%             disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
%             break;
%         end
% 
%     end
% 
%     % if isOnSegment(triangulation.ConnectivityList(nRowGoal,1), triangulation.ConnectivityList(nRowGoal,2) ,points_sequence(end)) || isOnSegment(triangulation.ConnectivityList(nRowGoal,2), triangulation.ConnectivityList(nRowGoal,3) ,points_sequence(end)) || isOnSegment(triangulation.ConnectivityList(nRowGoal,1), triangulation.ConnectivityList(nRowGoal,3) ,points_sequence(end))
%         points_sequence=[points_sequence; goalNode];
%     % end
% 
%     x = points_sequence(:, 1); % Extract all rows from the first column
%     y = points_sequence(:, 2); % Extract all rows from the second column
% 
%     % Plot the points
%     hold on;
%     if f==1
%         if b==1 && stop==false
%             plot(x, y, 'bo-', 'LineWidth', 1); % 'bo-' specifies blue circles connected by lines
%         elseif b==2 && stop==false
%             plot(x, y, 'bo-', 'LineWidth', 1);
%         elseif b==3 && stop==false
%             plot(x, y, 'bo-', 'LineWidth', 1);
%         elseif b==4 && stop==false
%             plot(x, y, 'bo-', 'LineWidth', 1);
%         elseif b==5 && stop==false
%             plot(x, y, 'bo-', 'LineWidth', 1);
%         elseif b==6 && stop==false
%             plot(x, y, 'bo-', 'LineWidth', 1);
%         end
%     end
%     if f==2
%         if b==1 && stop==false
%             plot(x, y, 'mo-', 'LineWidth', 1); % 'bo-' specifies blue circles connected by lines
%         elseif b==2 && stop==false
%             plot(x, y, 'mo-', 'LineWidth', 1);
%         elseif b==3 && stop==false
%             plot(x, y, 'mo-', 'LineWidth', 1);
%         elseif b==4 && stop==false
%             plot(x, y, 'mo-', 'LineWidth', 1);
%         elseif b==5 && stop==false
%             plot(x, y, 'mo-', 'LineWidth', 1);
%         elseif b==6 && stop==false
%             plot(x, y, 'mo-', 'LineWidth', 1);
%         end
%     end
%     if f==3
%         if b==1 && stop==false
%             plot(x, y, 'go-', 'LineWidth', 1); % 'bo-' specifies blue circles connected by lines
%         elseif b==2 && stop==false
%             plot(x, y, 'go-', 'LineWidth', 1);
%         elseif b==3 && stop==false
%             plot(x, y, 'go-', 'LineWidth', 1);
%         elseif b==4 && stop==false
%             plot(x, y, 'go-', 'LineWidth', 1);
%         elseif b==5 && stop==false
%             plot(x, y, 'go-', 'LineWidth', 1);
%         elseif b==6 && stop==false
%             plot(x, y, 'go-', 'LineWidth', 1);
%         end
%     end
% disp('/////////////////////////////////////////////////////////////////////////////////////////////////');
% end
% 
% %%
% end
% %% 





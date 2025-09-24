close all
clear all
clear figure

tic

mappp.points=[];

mappp.lines=[];

mapp = import_data_catia_vrml('warehouse.wrl');

for i=1:size(mapp.points,2)
    if mapp.points(1,i)==0.02
        mappp.points=[mappp.points; mapp.points(2,i) mapp.points(3,i)]; % to put in vertical
    end
end

map.points=unique(mappp.points,'rows'); % to select the unique points

for i=1:size(mapp.lines,2)
    if mapp.points(1,mapp.lines(1,i))==0.02 && mapp.points(1,mapp.lines(2,i))==0.02
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


%% Triangulation
triangulation = delaunayTriangulation(map.points);
triplot(triangulation);

hold on;
plot(map.points(:,1), map.points(:,2), 'ro');

hold on;
for i=1:size(map.points,1)
    text(map.points(i,1),map.points(i,2),num2str(i),'Color','red');
end


%% Writing the number of the triangle in each triangle
P=triangulation.Points;
T=triangulation.ConnectivityList;

vertices1 = P(T(:,1), :);
vertices2 = P(T(:,2), :);
vertices3 = P(T(:,3), :);

triangle_centers = (vertices1 + vertices2 + vertices3) / 3;

num_triangles = size(T, 1);

hold on;
for i = 1:num_triangles
    % Get the center of the current triangle
    center = triangle_centers(i, :);

    % Display the triangle index at the center
    text(center(1), center(2), num2str(i), 'HorizontalAlignment', 'center');
end


startNode = [-0.2, 0.02];
goalNode = [0.2, 0.45];

nRowStart=whichTriangle(startNode, triangulation);
nRowGoal=whichTriangle(goalNode, triangulation);

all_paths_lenght=[];

adjMatrix = createAdjacencyMatrix(triangulation, map);

cont=0;
[allPaths, all_paths_lenght] = findAllPaths(adjMatrix, nRowStart, nRowGoal, cont, all_paths_lenght);

% Visualizzazione dei risultati
disp('All sequences of triangles found:');
for i = 1:length(allPaths)
    disp(allPaths{i});
end




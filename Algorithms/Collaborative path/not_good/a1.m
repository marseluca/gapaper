close all
clear all
clear figure

outerprofile=[];
innerprofile=[];
rows_to_exclude=[];
rows_to_keep=[];

mapp = import_data_catia_vrml('estrusion_.wrl');

mappp.points=mapp.points(1:2,:); %extracting only x and y coordinates

% map.points=unique(mappp.points','rows');
% map.lines=unique(mapp.lines','rows');

map.points=mappp.points';
map.lines=mapp.lines';

outerprofile_=[1; 2; 22; 21];
for i=1:size(outerprofile_,1)
    outerprofile=[outerprofile; map.points(outerprofile_(i,1),1:2)];
end

for i=1:size(outerprofile,1)
    for j=1:size(map.lines,1)
        if outerprofile(i,1)==map.lines(j,1) || outerprofile(i,1)==map.lines(j,2) || outerprofile(i,2)==map.lines(j,1) || outerprofile(i,2)==map.lines(j,2)
            rows_to_exclude=[rows_to_exclude; j];
        end
    end
end

rows_to_keep = setdiff(1:size(map.lines, 1), rows_to_exclude);
innerprofile_ = map.lines(rows_to_keep, :);
for i=1:size(innerprofile_,1)
    innerprofile=[innerprofile; map.points(innerprofile_(i,1),1:2)];
    innerprofile=[innerprofile; map.points(innerprofile_(i,2),1:2)];
end
outerprofile__=unique(outerprofile,'rows');
innerprofile__=unique(innerprofile,'rows');

P=[outerprofile__;innerprofile__];
innerc1=[10 9; 9 14; 14 13; 13 7; 7 8; 8 10];
innerc2=[6 12; 12 11; 11 5; 5 6];
innerc3=[16 18; 18 17; 17 15; 15 16];
innerc4=[20 22; 22 21; 21 19; 19 20];
%innerc=[8 7; 7 12; 12 11; 11 5; 5 6; 6 8; 4 10; 10 9; 9 3; 3 4; 4 10; 14 16; 16 15; 15 13; 13 14; 18 20; 20 19; 19 17; 17 18];
outerc=[4 24; 24 23; 23 3; 3 4];
C=[outerc; innerc1; innerc2; innerc3; innerc4];

% Triangulate the geometry
triangulation = delaunayTriangulation(P,C);

% Visualize the triangulated geometry
figure
triplot(triangulation);
hold on;
plot(map.points(:,1), map.points(:,2), 'ro');

mmap.points=unique(map.points,'rows');
for i=1:size(mmap.points,1)
%     mmap.points=unique(map.points,'rows');
    text(mmap.points(i,1),mmap.points(i,2),num2str(i),'Color','red');
end

hold on 
plot(triangulation.Points(innerc1',1),triangulation.Points(innerc1',2), ...
     '-r','LineWidth',2)  
plot(triangulation.Points(innerc2',1),triangulation.Points(innerc2',2), ...
     '-r','LineWidth',2) 
plot(triangulation.Points(innerc3',1),triangulation.Points(innerc3',2), ...
     '-r','LineWidth',2) 
plot(triangulation.Points(innerc4',1),triangulation.Points(innerc4',2), ...
     '-r','LineWidth',2) 
% plot(triangulation.Points(outerc',1),triangulation.Points(outerc',2), ...
%      '-r','LineWidth',2)
axis equal 

%% To remove points inside the boundaries
figure
TF = isInterior(triangulation);
triplot(triangulation.ConnectivityList(TF,:),triangulation.Points(:,1),triangulation.Points(:,2))  
hold on
% plot(triangulation.Points(outercons',1),triangulation.Points(outercons',2), ...
%      '-r','LineWidth',2)
%plot(triangulation.Points(innerc1',1),triangulation.Points(innerc2',1),triangulation.Points(innerc3',1),triangulation.Points(innerc4',1),triangulation.Points(innerc1',2),triangulation.Points(innerc2',2),triangulation.Points(innerc3',2),triangulation.Points(innerc4',2), ...
%     '-r','LineWidth',2) 
axis equal;

%% List of the middle points of the edges

new_conn_list=triangulation.ConnectivityList(TF,:);
edges_list=[];
for i=1:size(new_conn_list,1)
    edges_list=[edges_list; new_conn_list(i,1:2); new_conn_list(i,2:3)];
end

middlepoints=[];
p1=[];
p2=[];
mx=0;
my=0;
for i=1:size(edges_list,1)
    p1=triangulation.Points(edges_list(i,1),:);
    p2=triangulation.Points(edges_list(i,2),:);

    mx=(p1(1)+p2(1))/2;
    my=(p1(2)+p2(2))/2;

    middlepoints=[middlepoints; mx, my];
end

num_middlepoints=size(middlepoints,1);


    
dt=delaunayTriangulation(triangulation.ConnectivityList(TF,:), triangulation.Points);

%% RRT*

% Define start and goal points
startPoint = [-0.1, -0.04];
goalPoint = [0.1, 0.05];

% Initialize RRT* tree with the start point
rrtTree = robotics.RRTStar(dt);
rrtTree.MaxNumTreeNodes = 300; 

% Goal tolerance
goalTolerance = 0.5;

% Main loop
for i = 1:rrtTree.MaxNumTreeNodes
    
    random_index=randi(num_middlepoints);
    randomPoint = [middlepoints(random_index,1), middlepoints(random_index,1)]; 
    
    % Find nearest node in the tree to the random point
    [nearestNode, ~] = nearest(rrtTree, randomPoint);
    
    % Attempt to extend the tree towards the random point
    extendedNode = steer(rrtTree, nearestNode, randomPoint);

    % Check for collision with obstacles using Delaunay triangulation
    if isCollisionFree(dt, nearestNode, extendedNode)
        % Add the extended node to the tree
        rrtTree.add(extendedNode, nearestNode);
        
        % Check if the goal is reached
        if norm(extendedNode.Position - goalPoint) < goalTolerance
            disp('Goal reached!');
            break;
        end
    end
    
    % Optimize the tree
    optimize(rrtTree, 10); % Perform rewiring
end

% Extract path from start to goal
path = findpath(rrtTree, startPoint, goalPoint);

% Plot the Delaunay triangulation and RRT* tree
figure;
triplot(dt); % Plot Delaunay triangulation
hold on;
plot(rrtTree); % Plot RRT* tree
plot(path(:,1), path(:,2), 'r', 'LineWidth', 2); % Plot path
plot(startPoint(1), startPoint(2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g'); % Plot start point
plot(goalPoint(1), goalPoint(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Plot goal point
xlabel('X');
ylabel('Y');
title('RRT* Path Planning with Delaunay Triangulation');
legend('Delaunay Triangulation', 'RRT* Tree', 'Optimal Path', 'Start Point', 'Goal Point');

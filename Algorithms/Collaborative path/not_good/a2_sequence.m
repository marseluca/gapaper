close all
clear all
clear figure

mappp.points=[];

mappp.lines=[];

mapp = import_data_catia_vrml('estrusion_.wrl');

for i=1:size(mapp.points,2)
    if mapp.points(3,i)==0
        mappp.points=[mappp.points; mapp.points(1,i) mapp.points(2,i)];
    end
end

% map.points=unique(mappp.points','rows');
% map.lines=unique(mapp.lines','rows');

map.points=unique(mappp.points,'rows');

for i=1:size(mapp.lines,2)
    if mapp.points(3,mapp.lines(1,i))==0 && mapp.points(3,mapp.lines(2,i))==0
        x1=mapp.points(1,mapp.lines(1,i)); 
        y1=mapp.points(2,mapp.lines(1,i));
        x2=mapp.points(1,mapp.lines(2,i)); 
        y2=mapp.points(2,mapp.lines(2,i));
        for j=1:size(map.points,1)
            if x1==map.points(j,1) && y1==map.points(j,2)
                jj=j;
            end
        end
        for z=1:size(map.points,1)
            if x2==map.points(z,1) && y2==map.points(z,2)
                zz=z;
            end
        end
        mappp.lines=[mappp.lines; jj zz];
        
    end
end
map.lines=unique(mappp.lines, 'rows');

max_x=max(map.points(:,1));
min_x=min(map.points(:,1));

max_y=max(map.points(:,2));
min_y=min(map.points(:,2));

%% Triangulation

outerprofile=[];
innerprofile=[];
rows_to_exclude=[];
rows_to_keep=[];


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
% for i=1:size(mmap.points,1)
% %     mmap.points=unique(map.points,'rows');
%     text(mmap.points(i,1),mmap.points(i,2),num2str(i),'Color','red');
% end

for i=1:size(triangulation.Points,1)
%     mmap.points=unique(map.points,'rows');
    text(triangulation.Points(i,1),triangulation.Points(i,2),num2str(i),'Color','red');
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
% 
% % To remove points inside the boundaries
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
% Creating a vector of middle points (each row is made by the coordinates)
middle_points_=[];
    for i=1:size(conc_edges,1)
        p1=conc_edges(i,1);
        p2=conc_edges(i,2);

        c1=triangulation.Points(p1,:);
        c2=triangulation.Points(p2,:);
        
        mx=(c1(1)+c2(1))/2;
        my=(c1(2)+c2(2))/2;

        middle_points_=[middle_points_; mx my];

    end
    middle_points=unique(middle_points_,'rows');
for i=1:size(middle_points,1)
    text(middle_points(i,1),middle_points(i,2),num2str(i),'Color','green');
end


%% RRT*
% Define start and goal points
startNode = [-0.1, -0.04];
goalNode = [0.1, 0.05];

maxIter=6000;
% maxDistance=0.01;
goalThreshold=0.02;
rewiringRadius=0.05;

tree = Tree();
tree.root = Node();
tree.root.position = startNode;
tree.root.parent = [];
tree.root.cost = 0;
tree.nodes = Node.empty(0, 1);
tree.nodes=[tree.nodes; tree.root];

%% Main loop
triangles=triangle.empty(0,1);

[nRowStart,pStart]=whichTriangle(startNode, triangulation); %first input is a coordinate (x and y)
[nRowGoal,pGoal]=whichTriangle(goalNode, triangulation);

startTriangle=triangle();
startTriangle.row=nRowStart;
startTriangle.exp=1;
startTriangle.done=1;
triangles=[triangles; startTriangle];

realEdgesStart=findRealEdges(nRowStart, triangulation, map);
virtualEdgesStart=findVirtualEdges(nRowStart, triangulation, realEdgesStart);

chosen=[0];
explored=[nRowStart];
goalTriangleReached=false;

for i=1:size(virtualEdgesStart,1)
    
    randomRow_ = randi([1, size(virtualEdgesStart,1)]);
    if ~ismember(chosen, randomRow_, "rows")
        chosen=[chosen; randomRow_];
        randomRow=randomRow_;
    else break;
    end

    randomEdge=virtualEdgesStart(randomRow,:);
    triangleIndex = findTriangleContainingEdge(triangulation.ConnectivityList, randomEdge, explored);
    explored=[explored; triangleIndex];
    if ismember(explored,nRowGoal)
        disp('The triangle containing the goal node has been reached');
        goalTriangleReached=true;
        break;
    else
        while goalTriangleReached==false

        end
    end






end
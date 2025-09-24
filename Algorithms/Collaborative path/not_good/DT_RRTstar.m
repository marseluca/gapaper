close all
clear all
clear figure

% [vertices, faces, ~, ~, ~] = stlread('estrusion_.stl');
tr=stlread('estrusion_.stl');

figure;
trisurf(tr);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D STL');

%% Extraction of a 2D surface (x=-5)
vertices=tr.Points;
faces=tr.ConnectivityList;
zeroXIndices = find(vertices(:, 1) == -5); %indices without repetitions

% Find the faces that contain those vertices
selectedFacesIndex = [];
for i = 1:length(zeroXIndices)
    vertexIndex = zeroXIndices(i);
    matchingFaces = find(sum( ismember(faces, vertexIndex) , 2) == 1); %matchingFaces will contain (should contain) the index (which row) of faces that include the indexed vertex
    selectedFacesIndex = [selectedFacesIndex; matchingFaces]; %just indexes of those faces (rows,1) with repetitions
end

[uniqueElements, ~, idx] = unique(selectedFacesIndex);
counts = accumarray(idx, 1);

% Find elements that repeat exactly three times
repeatedThreeTimes = uniqueElements(counts == 3);

% Extract the corrensponding unique faces
f=faces(repeatedThreeTimes , :);

r=size(f,1); %how many selectedFaces we have (unique ones)
c=size(f,2);

verticesFacesIndex=[];
for i=1:r
    for j=1:c
        verticesFacesIndex=[verticesFacesIndex; f(i,j)];
    end
end 

vv=unique(verticesFacesIndex);
selectedVertices = vertices(vv, :);
% selectedFaces = (1:size(selectedVertices, 1))';
% selectedFaces=faces(selectedFacesIndex,:);

% Visualize the selected 2D plane
figure;
% patch('Faces', f, 'Vertices', selectedVertices, 'FaceColor', [0.8 0.8 1.0], 'EdgeColor', 'none');
p=patch('Faces', f, 'Vertices', selectedVertices, 'FaceColor', [0.8 0.8 1.0], 'EdgeColor', 'none');

yy=[];
zz=[];
yy=p.YData;
zz=p.ZData;

axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Plane with x = -5 coordinate');

DT = delaunayTriangulation(selectedVertices(:,2),selectedVertices(:,3));

figure
triplot(DT,selectedVertices(:,2),selectedVertices(:,3));
hold on;
plot(selectedVertices(:,2), selectedVertices(:,3), 'ro');

for i=1:size(selectedVertices,1)
    text(selectedVertices(i,2),selectedVertices(i,3),num2str(i),'Color','red');
end

axis equal;
xlabel('Y');
ylabel('Z');
zlabel(' ');
title('Triangulated 2D map');
hold off;


dt_r=size(DT.ConnectivityList,1);
dt_c=size(DT.ConnectivityList,2);

point1=[];
point2=[];
point3=[];
vertex1=[];
vertex2=[];
vertex3=[];
middlepoint=[];
isInside=[];
count=0;

v_patch=[];
f_patch=[];
v_patch=p.Vertices;
f_patch=p.Faces;
rows_to_exclude=[];
rows_to_keep=[];
new_ConnectivityList=[];
new_ConnectivityList_final=[];
aaa=0;
isIns=[];

for i=1:dt_r
    point1=DT.ConnectivityList(i,1);
    point2=DT.ConnectivityList(i,2);
    point3=DT.ConnectivityList(i,3);
    vertex1=DT.Points(point1,:);
    vertex2=DT.Points(point2,:);
    vertex3=DT.Points(point3,:);
    middlepoint(1,:)=(vertex1 + vertex2)/2;
    middlepoint(2,:)=(vertex2 + vertex3)/2;
    middlepoint(3,:)=(vertex1 + vertex3)/2;

    boundaryPoints = boundary(v_patch(:,2), v_patch(:,3));
    epsilon = 1e-10;

    for j=1:size(middlepoint,1)
        isInside = inpolygon(middlepoint(j,1), middlepoint(j,2), v_patch(:,2)', v_patch(:,3)') || any(sqrt((middlepoint(j,1) - v_patch(:,2)'(boundaryPoints)).^2 + (middlepoint(j,2) - v_patch(:,3)'(boundaryPoints)).^2) < epsilon);
        isIns=[isIns; isInside];
    end   
%     in = inpolygon(middlepoint(:,1), middlepoint(:,2), v_patch(:,2), v_patch(:,3));
% 
%     for w=1:size(in,1)
%         if in(w,1)==0
%           if w==1
%               DT.ConnectivityList=rmedge(DT.ConnectivityList, point1,point2);
%           elseif w==2
%               DT.ConnectivityList=rmedge(DT.ConnectivityList, point2, point3);
%           elseif w==3
%               DT.ConnectivityList=rmedge(DT.ConnectivityList, point1, point3);
%           end
%         end
%     end
    
    
    for w=1:size(isInside,1)
        if isInside(w,1)==0
            count=count+1;
        end
    end

    if count>0
        rows_to_exclude=[rows_to_exclude; i];
    end

    count=0;
    if i<46
        isInside=[];
    else
        isInside;
    end
isIns=[];
end

rows_to_keep = setdiff(1:size(DT.ConnectivityList, 1), rows_to_exclude);
new_ConnectivityList = DT.ConnectivityList(rows_to_keep, :);

for i=1:size(new_ConnectivityList,1)
    new_ConnectivityList_final=[new_ConnectivityList_final; new_ConnectivityList(i,1); new_ConnectivityList(i,2); new_ConnectivityList(i,3)];
end

edge_vertices = unique(new_ConnectivityList_final,'rows');

% Create the Delaunay triangulation for these vertices
dt2 = delaunayTriangulation(selectedVertices(edge_vertices,2), selectedVertices(edge_vertices,3));

figure
triplot(dt2,selectedVertices(:,2),selectedVertices(:,3));
hold on;
plot(selectedVertices(:,2), selectedVertices(:,3), 'ro');
axis equal;
xlabel('Y');
ylabel('Z');
zlabel(' ');
title('Triangulated 2D map with selected edges');
hold off;
% 
% hold on;
% triplot(DT);


    


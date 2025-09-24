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

g_vertices=[];
point1=[];
point2=[];
point3=[];
vertex1=[];
vertex2=[];
vertex3=[];

for i=1:dt_r
    vertex1=DT.ConnectivityList(i,1);
    vertex2=DT.ConnectivityList(i,2);
    vertex3=DT.ConnectivityList(i,3);
%     point1=DT.Points(vertex1,:);
%     point2=DT.Points(vertex2,:);
%     point3=DT.Points(vertex3,:);
    g_vertices=[g_vertices; vertex1, vertex2; vertex2, vertex3]
end

g1=unique(g_vertices(:,1),'rows');
G=graph(gg(:,1),gg(:,2));
figure;
plot(G);





    


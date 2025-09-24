close all
clear all
clear figure

% load('Workspaces\couples.mat');
% load('Workspaces\couples3.mat');

mappp.points=[];
mappp.lines=[];

% mapp = import_data_catia_vrml('warehouse.wrl');
mapp = import_data_catia_vrml('warehouse3.wrl');

%% Warehouse
% for i=1:size(mapp.points,2)
%     if mapp.points(1,i)==-0.02
%         mappp.points=[mappp.points; mapp.points(2,i) mapp.points(3,i)];
%     end
% end
% 
% map.points=unique(mappp.points,'rows');
% map.points=map.points*2000;
% 
% for i=1:size(mapp.lines,2)
%     if mapp.points(1,mapp.lines(1,i))==-0.02 && mapp.points(1,mapp.lines(2,i))==-0.02
%         x1=mapp.points(2,mapp.lines(1,i)); 
%         y1=mapp.points(3,mapp.lines(1,i));
%         x2=mapp.points(2,mapp.lines(2,i)); 
%         y2=mapp.points(3,mapp.lines(2,i));
%         for j=1:size(map.points,1)
%             if x1*2000==map.points(j,1) && y1*2000==map.points(j,2)
%                 jj=j;
%             end
%         end
%         for z=1:size(map.points,1)
%             if x2*2000==map.points(z,1) && y2*2000==map.points(z,2)
%                 zz=z;
%             end
%         end
%         mappp.lines=[mappp.lines; jj zz];
% 
%     end
% end
% map.lines=unique(mappp.lines, 'rows');

%% Warehouse3

for i=1:size(mapp.points,2)
    if mapp.points(1,i)==-0.02
        mappp.points=[mappp.points; mapp.points(2,i) mapp.points(3,i)]; % to put in vertical
    end
end

map.points=unique(mappp.points,'rows'); % to select the unique points
map.points=map.points*2000;

for i=1:size(mapp.lines,2)
    if mapp.points(1,mapp.lines(1,i))==-0.02 && mapp.points(1,mapp.lines(2,i))==-0.02
        x1=mapp.points(2,mapp.lines(1,i)); 
        y1=mapp.points(3,mapp.lines(1,i));
        x2=mapp.points(2,mapp.lines(2,i)); 
        y2=mapp.points(3,mapp.lines(2,i));
        for j=1:size(map.points,1)
            if x1*2000==map.points(j,1) && y1*2000==map.points(j,2)
                jj=j;
            end
        end
        for z=1:size(map.points,1)
            if x2*2000==map.points(z,1) && y2*2000==map.points(z,2)
                zz=z;
            end
        end
        mappp.lines=[mappp.lines; jj zz];

    end
end
% map.lines=unique(mappp.lines, 'rows');
map.lines=mappp.lines;

%% Plot the map
% for i=1:size(map.lines,1)
%     x1=map.points(map.lines(i,1),1);
%     y1=map.points(map.lines(i,1),2);
%     x2=map.points(map.lines(i,2),1);
%     y2=map.points(map.lines(i,2),2);
% 
%     x=[x1 x2];
%     y=[y1 y2];
%     hold on;
%     plot(x, y, '-r','LineWidth',2);
% end


max_x=max(map.points(:,1));
min_x=min(map.points(:,1));

max_y=max(map.points(:,2));
min_y=min(map.points(:,2));

%% RRT*
% Define start and goal points

%For the first map
% startNode = [-0.1, -0.04];
% goalNode = [0.1, 0.05];

%% For the warehouse 1
% startNode = [-400, 8];
% goalNode = [-200, 860];


startNode = [-400, 8];
goalNode = [600, 950];


maxIter=2000;
maxDistance=0.02*2000;
goalThreshold=0.02*2000;
rewiringRadius=0.05*2000; %0.05

num_paths_3=200;

% paths_3 = inf(num_paths_3*size(couples3,1),3);
paths_3 = inf(num_paths_3,3);
rewiring_times=[];

circle_radius =  0.003*2000; 
safety_margin = circle_radius + circle_radius*0.05; %+il 5%


for loopp = 1:1    %size(couples3,1)

    % startNode=couples3(loopp,1:2);
    % goalNode=couples3(loopp,3:4);
    
    i=0;
    
    % tocss=[];
    while i<num_paths_3
        % tic;
        tree = Tree();
        tree.root = Node();
        tree.root.position = startNode;
        tree.root.parent = [];
        tree.root.cost = 0;
        tree.nodes = [];
        tree.nodes=[tree.nodes; tree.root];
        % toc1=toc;
        % tocss=[tocss; toc1];
    
        toc1_=0;
        toc2_=0;
        %% Main loop
        for iter = 1:maxIter
            
            % tic;
            % Attempt to extend the tree towards the random point
            [tree, nearNodes,const, newNode, rewiredNodes, exceedNodes, toc1,toc2] = extendTree(max_x, min_x, max_y, min_y, tree, maxDistance, rewiringRadius, map, safety_margin); %create q_new nodo (con coordinate)
            toc1_=toc1_+toc1;
            toc2_=toc2_+toc2;
            % tocss=[tocss; toc2];
            if exceedNodes==true
                break;
            end
            
            if exceedNodes==false %if the max number of tree.nodes has not been reached
                % Check if reached goal
                check=goalNode-newNode.position;
                if norm(check) < goalThreshold
                    % tic;
                    goalNode_ = newNode;
                    tic;
                    path = findPath(tree, goalNode_);
                    toc3=toc;
                    toc1_=toc1_+toc3;
                    % toc3=toc;
                    % tocss=[tocss; toc3];
                    break;
                end
            end
            
        end
        
        if exceedNodes==false
            i=i+1;
            % visualizeTree(tree);
            % hold on;
            % if ~isempty(path)
            %     plot(path(:,1), path(:,2), 'r', 'LineWidth', 2);
            % end
            % disp('After concatenation:');
            % for i=1:size(tree.nodes,1)
            %    disp(tree.nodes(i));
            % end
        end
        %% Calcolo distanza totale path
        if exceedNodes==false
            x = path(:, 1);
            y = path(:, 2);
            dx = diff(x);
            dy = diff(y);
            distances = sqrt(dx.^2 + dy.^2);
            total_distance = sum(distances);
        
            % fprintf('Elapsed time is %.2f seconds.\n', elapsedTime);
            % total_time=time1+time2;
            paths_3((((loopp-1)*num_paths_3)+i),1)=loopp;
            paths_3((((loopp-1)*num_paths_3)+i),2)=toc1_-toc2_;
            paths_3((((loopp-1)*num_paths_3)+i),3)=total_distance;
            rewiring_times=[rewiring_times; toc2_];
        end
    
    
    end
end

%% Rimozione righe in cui 2 e 3 elemento sono nulli perchè si era ecceduto numero max tree.nodes
rowsToRemove = isinf(paths_3(:, 2)) & isinf(paths_3(:, 3));
paths_3(rowsToRemove, :) = [];


% excel_file = 'paths_3_normal_RRT.xlsx';
% writematrix(paths_3, excel_file);
% 









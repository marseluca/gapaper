close all
clear all
clear figure

load('DT_RRT_star.mat');
load('RRT_star.mat');

time_scaling=0.5;
frameRate=1;

% video1 = VideoWriter('warehouse.avi');
% figure();
% open(video1);
% 
% %% Print map
% x = zeros(size(map.lines, 1), 2);
% y = zeros(size(map.lines, 1), 2);
% for i = 1:size(map.lines, 1)
%     x(i, :) = map.points(map.lines(i, :), 1);
%     y(i, :) = map.points(map.lines(i, :), 2);
% end
% 
% plot(x', y','-r','LineWidth',2); % Transpose to get the correct format for plot
% % pause(toc4+time_scaling); %pause for the time requested for triangulation
% hold on;
% 
% frame = getframe(gcf);
% writeVideo(video1, frame);
% 
% %% Pause for triangulation
% plot([], []);
% hold on;
% frame = getframe(gcf);
% for p = 1:frameRate*ceil(toc4*500) %pause for the time requested for triangulation
%     writeVideo(video1, frame);
% end
% 
% %% Print triangulation
% edges=[];
% for i=1:size(visited_order,1)
%     edges=[edges; triangulation.ConnectivityList(visited_order(i),1) triangulation.ConnectivityList(visited_order(i),2); triangulation.ConnectivityList(visited_order(i),2) triangulation.ConnectivityList(visited_order(i),3); triangulation.ConnectivityList(visited_order(i),3) triangulation.ConnectivityList(visited_order(i),1)];
%     %hold on;
%     plot(triangulation.Points(edges',1),triangulation.Points(edges',2),'-g','LineWidth',2);
%     frame = getframe(gcf);
%     for p = 1:frameRate*ceil(tocs(i)*500)
%         writeVideo(video1, frame);
%     end
% end
% 
% %% Pause for the time needed to place the samples on the edges
% plot([], []);
% hold on;
% frame = getframe(gcf);
% for p = 1:frameRate*ceil(toc2*500) %pause for the time needed to place the samples
%     writeVideo(video1, frame);
% end
% 
% %% Plotting the path
% %hold on;
% plot(dynMatrix{3}(1), dynMatrix{3}(2), 'ro');
% frame = getframe(gcf);
% for p = 1:frameRate*ceil(tocs2(1)*500)
%     writeVideo(video1, frame);
% end
% 
% for i=4:length(dynMatrix)
%     if i==4
%         %hold on;
%         plot(dynMatrix{4}(1), dynMatrix{4}(2), 'ro');
%         %hold on;
%         frame = getframe(gcf);
%         writeVideo(video1, frame);
%         plot([dynMatrix{3}(1), dynMatrix{4}(1)], [dynMatrix{3}(2), dynMatrix{4}(2)], 'r-');
%         frame = getframe(gcf);
%         for p = 1:frameRate*ceil(tocs2(2)*500)
%             writeVideo(video1, frame);
%         end
%     else
%         %hold on;
%         plot(dynMatrix{i}(1), dynMatrix{i}(2), 'ro');
%         frame = getframe(gcf);
%         writeVideo(video1, frame);
%         %hold on;
%         plot([dynMatrix{i-1}(1), dynMatrix{i}(1)], [dynMatrix{i-1}(2), dynMatrix{i}(2)], 'r-');
%         frame = getframe(gcf);
%         for p = 1:frameRate*ceil(tocs2(i-2)*500)
%             writeVideo(video1, frame);
%         end
%     end
% end
% 
% close(video1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



video2 = VideoWriter('warehouse2.avi');
figure();
open(video2);

%% Print map
x = zeros(size(map.lines, 1), 2);
y = zeros(size(map.lines, 1), 2);
for i = 1:size(map.lines, 1)
    x(i, :) = map.points(map.lines(i, :), 1);
    y(i, :) = map.points(map.lines(i, :), 2);
end

plot(x', y','-r','LineWidth',2); 
frame = getframe(gcf);
writeVideo(video2, frame);

hold on;
plot(tree.nodes(1).position(1), tree.nodes(1).position(2), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
frame = getframe(gcf);
writeVideo(video2, frame);

%% Plot the tree
for i = 2:size(tree.nodes,1)
    % Get current node and its parent
    currentNode = tree.nodes(i);
    parentNode = currentNode.parent;

    % Get positions
    currentPos = currentNode.position;
    parentPos = parentNode.position;

    % Plot the edge (line) from parent to current node
    hold on;
    plot([parentPos(1)*2000, currentPos(1)*2000], [parentPos(2)*2000, currentPos(2)*2000], 'b-', 'LineWidth', 1);
    frame = getframe(gcf);
    writeVideo(video2, frame);

    % Plot the current node
    hold on;
    plot(currentPos(1)*2000, currentPos(2)*2000, 'ro', 'MarkerSize', 2, 'MarkerFaceColor', 'r');

    frame = getframe(gcf);
    for p = 1:frameRate*ceil(tocss(i)*500)
       writeVideo(video2, frame);
    end
end

frame=getframe(gcf);
for p = 1:frameRate*ceil(tocss(end)*500)
   writeVideo(video2, frame);
end
hold on;
plot(path(:,1)*2000, path(:,2)*2000, 'r', 'LineWidth', 2);
frame=getframe(gcf);
writeVideo(video2, frame);

close(video2);
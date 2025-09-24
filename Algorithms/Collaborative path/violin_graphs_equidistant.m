close all
clear all
clear figure

load('Workspaces/paths_dtrrt_couples_equidistant.mat');

%% RRT*
% v1=violin({paths(:,2)}, 'facecolor', [0.8 0.2 0.2]);
% 
% legend_labels = {'RRT*'};
% 
% hold on;
% h = zeros(length(v1), 1);
% for i = 1:length(v1)
%     h(i) = plot(NaN, NaN, 's', 'MarkerSize', 10, 'MarkerFaceColor', v1(i).FaceColor, 'MarkerEdgeColor', 'none');
% end
% 
% legend(h, legend_labels, 'Location', 'northeast');
% 
% 
% means = cellfun(@mean, {paths(:,2)});
% medians = cellfun(@median, {paths(:,2)});
% 
% Calculate the mean and median of the rewiring times
% mean_rewiring = mean(rewiring_times);
% median_rewiring = median(rewiring_times);
% 
% hold on;
% 
% for i = 1:length(v1)
%     mean_pos = means(i);
%     median_pos = medians(i);
% 
%     x_pos = i;
% 
%     text(x_pos, mean_pos, sprintf('%.2f', mean_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'k', 'FontSize', 10);
%     text(x_pos, median_pos, sprintf('%.2f', median_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Color', 'r', 'FontSize', 10);
% end
% 
% % Adding line for mean of the rewiring times
% mean_rewiring_line = line(xlim, [mean_rewiring mean_rewiring], 'Color', 'g', 'LineWidth', 1, 'LineStyle', '--');
% x_center = mean(xlim); 
% text(x_center, mean_rewiring, sprintf('%.2f', mean_rewiring), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'g', 'FontSize', 10);
% 
% % Adding line for median of the rewiring times
% median_rewiring_line = line(xlim, [median_rewiring median_rewiring], 'Color', 'y', 'LineWidth', 1, 'LineStyle', '--');
% x_center = mean(xlim); 
% text(x_center, median_rewiring, sprintf('%.2f', median_rewiring), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'y', 'FontSize', 10);
% 
% 
% legend([h; mean_rewiring_line; median_rewiring_line], [legend_labels, {'Rewiring mean', 'Rewiring median'}], 'Location', 'northeast', 'FontSize', 10);


%% DT-RRT*
v2=violin({paths_dtrrt(:,3)}, 'facecolor', [0.5 0.5 0.5], 'edgecolor', [0.5 0.5 0.5]);

ax = gca; 
ax.XTickLabel = [];

xlabel('Experience 1');
ylabel('Time [s]');

legend_labels = {'DT-RRT*'};

hold on;
h = zeros(length(v2), 1);
for i = 1:length(v2)
    h(i) = plot(NaN, NaN, 's', 'MarkerSize', 10, 'MarkerFaceColor', v2(i).FaceColor, 'MarkerEdgeColor', 'none');
end

legend(h, legend_labels, 'Location', 'northeast');


means = cellfun(@mean, {paths_dtrrt(:,3)});
medians = cellfun(@median, {paths_dtrrt(:,3)});

mean_samples = mean(toc2);
median_samples = median(toc2);

hold on;

for i = 1:length(v2)
    mean_pos = means(i);
    median_pos = medians(i);
    
    x_pos = i;
    
    text(x_pos, mean_pos, sprintf('%.4f', mean_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'k', 'FontSize', 10);
    text(x_pos, median_pos, sprintf('%.4f', median_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Color', 'r', 'FontSize', 10);
end


%% Adding line for triangulation
triangulation_line = line(xlim, [toc1 toc1], 'Color', 'b', 'LineWidth', 1, 'LineStyle', '--');
x_center = mean(xlim);
text(x_center, toc1, sprintf('%.4f', toc1), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'b', 'FontSize', 10);

%% Adding line for mean of the rewiring times
mean_samples_line = line(xlim, [mean_samples mean_samples], 'Color', 'g', 'LineWidth', 1, 'LineStyle', '--');
x_center = mean(xlim); 
text(x_center, mean_samples, sprintf('%.2f', mean_samples), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'g', 'FontSize', 10);

%% Adding line for median of the rewiring times
median_samples_line = line(xlim, [median_samples median_samples], 'Color', 'y', 'LineWidth', 1, 'LineStyle', '--');
x_center = mean(xlim); 
text(x_center, median_samples, sprintf('%.2f', median_samples), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'y', 'FontSize', 10);

legend([h; triangulation_line; mean_samples_line; median_samples_line], [legend_labels, {'Triangulation','Seq.+sampl. mean', 'Seq.+sampl. median'}], 'Location', 'northeast', 'FontSize', 10);
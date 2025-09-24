close all
clear all
clear figure

% load('Workspaces/paths_rrt_one_couple.mat');
load('Workspaces/paths_rrt_one_couple_2.mat');

%% RRT*
v1=violin({paths(:,2)}, 'facecolor', [0.8 0.2 0.2], 'edgecolor', [0.8 0.2 0.2]);

ax = gca; 
ax.XTickLabel = [];

% xlabel('Map1,first fixed couple');
xlabel('Map1,second fixed couple');
ylabel('Time [s]');

legend_labels = {'RRT*'};

hold on;
h = zeros(length(v1), 1);
for i = 1:length(v1)
    h(i) = plot(NaN, NaN, 's', 'MarkerSize', 10, 'MarkerFaceColor', v1(i).FaceColor, 'MarkerEdgeColor', 'none');
end

h_mean = plot(nan, nan, 'k-', 'LineWidth', 2);
h_median = plot(nan, nan, 'r-', 'LineWidth', 2);

legend(h, legend_labels, 'Location', 'northeast');


means = cellfun(@mean, {paths(:,2)});
medians = cellfun(@median, {paths(:,2)});

% Calculate the mean and median of the rewiring times
mean_rewiring = mean(rewiring_times);
median_rewiring = median(rewiring_times);

hold on;

for i = 1:length(v1)
    mean_pos = means(i);
    median_pos = medians(i);

    x_pos = i;

    text(x_pos, mean_pos, sprintf('%.2f', mean_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'k', 'FontSize', 10);
    text(x_pos, median_pos, sprintf('%.2f', median_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Color', 'r', 'FontSize', 10);
end

% Adding line for mean of the rewiring times
mean_rewiring_line = line(xlim, [mean_rewiring mean_rewiring], 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
x_center = mean(xlim); 
text(x_center, mean_rewiring, sprintf('%.2f', mean_rewiring), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'm', 'FontSize', 10);

% Adding line for median of the rewiring times
median_rewiring_line = line(xlim, [median_rewiring median_rewiring], 'Color', 'c', 'LineWidth', 1, 'LineStyle', '--');
x_center = mean(xlim); 
text(x_center, median_rewiring, sprintf('%.2f', median_rewiring), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'c', 'FontSize', 10);


legend([h; mean_rewiring_line; median_rewiring_line; h_mean; h_median], [legend_labels, {'Rewiring mean', 'Rewiring median', 'Mean', 'Median'}], 'Location', 'northeast', 'FontSize', 10);



close all
clear all
clear figure

load('Workspaces/paths_rrt_one_couple.mat');
% load('Workspaces/paths_rrt_one_couple_2.mat');

%% RRT*
v1=violin({paths(:,3)}, 'facecolor', [0.8 0.2 0.2], 'edgecolor', [0.8 0.2 0.2]);

ax = gca; 
ax.XTickLabel = [];

xlabel('Map1,first fixed couple');
% xlabel('Map1,second fixed couple');
ylabel('Length [m]');

legend_labels = {'RRT*'};

hold on;
h = zeros(length(v1), 1);
for i = 1:length(v1)
    h(i) = plot(NaN, NaN, 's', 'MarkerSize', 10, 'MarkerFaceColor', v1(i).FaceColor, 'MarkerEdgeColor', 'none');
end

h_mean = plot(nan, nan, 'k-', 'LineWidth', 2);
h_median = plot(nan, nan, 'r-', 'LineWidth', 2);

legend(h, legend_labels, 'Location', 'northeast');


means = cellfun(@mean, {paths(:,3)});
medians = cellfun(@median, {paths(:,3)});

hold on;

for i = 1:length(v1)
    mean_pos = means(i);
    median_pos = medians(i);

    x_pos = i;

    text(x_pos, mean_pos, sprintf('%.2f', mean_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'k', 'FontSize', 10);
    text(x_pos, median_pos, sprintf('%.2f', median_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Color', 'r', 'FontSize', 10);
end


legend([h; h_mean; h_median], [legend_labels, {'Mean', 'Median'}], 'Location', 'northeast', 'FontSize', 10);



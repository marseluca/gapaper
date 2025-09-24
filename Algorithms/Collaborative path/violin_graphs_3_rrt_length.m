close all
clear all
clear figure

load('Workspaces/paths_rrt_3_couples.mat');

%% RRT*
v1=violin({paths_3(:,3)}, 'facecolor', [0.8 0.2 0.2], 'edgecolor', [0.8 0.2 0.2]);

ax = gca; 
ax.XTickLabel = [];

xlabel('Experience 2 RRT* length');
ylabel('Length [m]');

legend_labels = {'RRT*'};

hold on;
h = zeros(length(v1), 1);
for i = 1:length(v1)
    h(i) = plot(NaN, NaN, 's', 'MarkerSize', 10, 'MarkerFaceColor', v1(i).FaceColor, 'MarkerEdgeColor', 'none');
end

legend(h, legend_labels, 'Location', 'northeast');


means = cellfun(@mean, {paths_3(:,3)});
medians = cellfun(@median, {paths_3(:,3)});

hold on;

for i = 1:length(v1)
    mean_pos = means(i);
    median_pos = medians(i);

    x_pos = i;

    text(x_pos, mean_pos, sprintf('%.2f', mean_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'k', 'FontSize', 10);
    text(x_pos, median_pos, sprintf('%.2f', median_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Color', 'r', 'FontSize', 10);
end


legend([h], [legend_labels, {}], 'Location', 'northeast', 'FontSize', 10);



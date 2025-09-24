close all
clear all
clear figure

% load('Workspaces/paths_dtrrt_one_couple_gaussian.mat');
load('Workspaces/paths_dtrrt_one_couple_2_gaussian.mat');

%% DT-RRT*
v2=violin({paths_dtrrt(:,4)}, 'facecolor', [0.5 0.5 0.5], 'edgecolor', [0.5 0.5 0.5]);

ax = gca; 
ax.XTickLabel = [];

% xlabel('Map1,first fixed couple,30 points Gaussian distr.,200 paths');
xlabel('Map1,second fixed couple,30 points Gaussian distr.,200 paths');
ylabel('Length [m]');

legend_labels = {'DT-RRT*'};

hold on;
h = zeros(length(v2), 1);
for i = 1:length(v2)
    h(i) = plot(NaN, NaN, 's', 'MarkerSize', 10, 'MarkerFaceColor', v2(i).FaceColor, 'MarkerEdgeColor', 'none');
end

legend(h, legend_labels, 'Location', 'northeast');


means = cellfun(@mean, {paths_dtrrt(:,4)});
medians = cellfun(@median, {paths_dtrrt(:,4)});

hold on;

for i = 1:length(v2)
    mean_pos = means(i);
    median_pos = medians(i);
    
    x_pos = i;
    
    text(x_pos, mean_pos, sprintf('%.4f', mean_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'k', 'FontSize', 10);
    text(x_pos, median_pos, sprintf('%.4f', median_pos), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Color', 'r', 'FontSize', 10);
end

h_mean = plot(nan, nan, 'k-', 'LineWidth', 2);
h_median = plot(nan, nan, 'r-', 'LineWidth', 2);


legend([h; h_mean; h_median], [legend_labels, {'Mean', 'Median'}], 'Location', 'northeast', 'FontSize', 10);
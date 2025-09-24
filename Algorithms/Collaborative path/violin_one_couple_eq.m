close all
clear all
clear figure

load('Workspaces/paths_dtrrt_one_couple_equidistant.mat');
% load('Workspaces/paths_dtrrt_one_couple_2_equidistant.mat');

%% DT-RRT*
v2=violin({paths_dtrrt(:,3)}, 'facecolor', [0.5 0.5 0.5], 'edgecolor', [0.5 0.5 0.5]);

ax = gca; 
ax.XTickLabel = [];

xlabel('Map1,first fixed couple,30 equidistant points,200 paths');
% xlabel('Map1,second fixed couple,30 equidistant points,200 paths');
ylabel('Time [s]');

% ylim([0.0319466, 0.094648]);

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

h_mean = plot(nan, nan, 'k-', 'LineWidth', 2);
h_median = plot(nan, nan, 'r-', 'LineWidth', 2);


%% Adding line for triangulation
triangulation_line = line(xlim, [toc1 toc1], 'Color', 'b', 'LineWidth', 1, 'LineStyle', '--');
x_center = mean(xlim);
text(x_center, toc1, sprintf('%.4f', toc1), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'b', 'FontSize', 10);

%% Adding line for seq+samples time
samples_line = line(xlim, [toc2 toc2], 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
x_center = mean(xlim); 
text(x_center, toc2, sprintf('%.2f', toc2), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'g', 'FontSize', 10);

legend([h; triangulation_line; samples_line;  h_mean; h_median], [legend_labels, {'Triangulation','Seq.+sampl.', 'Mean', 'Median'}], 'Location', 'northeast', 'FontSize', 10);
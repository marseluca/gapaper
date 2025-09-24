% Load the figure file
fig = openfig('untitled.fig');

% Get the current axes of the figure
ax = gca;

% Get all the lines (plots) in the current axes
lines = findobj(ax, 'Type', 'line');

% Define the scaling factor for the y-values
scale_factor = 1.1159;  % Example: scale all y-values by 2

% Loop through each line and scale the y-data
for i = 1:length(lines)
    % Get current x and y data
    x_data = get(lines(i), 'XData');
    y_data = get(lines(i), 'YData');
    
    % Scale the y-data
    y_data_scaled = y_data * scale_factor;
    
    % Update the plot with scaled y-values
    set(lines(i), 'YData', y_data_scaled);
end

% Optionally, save the updated figure
savefig('untitled_scaled.fig');

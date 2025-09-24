close all
clear all
clear figure

mappp.points=[];

mappp.lines=[];

mapp = import_data_catia_vrml('warehouse.wrl');

for i=1:size(mapp.points,2)
    if mapp.points(1,i)==0.02
        mappp.points=[mappp.points; mapp.points(2,i) mapp.points(3,i)]; % to put in vertical
    end
end

map.points=unique(mappp.points,'rows'); % to select the unique points
map.points=map.points*2000;

for i=1:size(mapp.lines,2)
    if mapp.points(1,mapp.lines(1,i))==0.02 && mapp.points(1,mapp.lines(2,i))==0.02
        x1=mapp.points(2,mapp.lines(1,i)); 
        y1=mapp.points(3,mapp.lines(1,i));
        x2=mapp.points(2,mapp.lines(2,i)); 
        y2=mapp.points(3,mapp.lines(2,i));
        for j=1:size(map.points,1)
            if x1*2000==map.points(j,1) && y1*2000==map.points(j,2) 
                jj=j;
            elseif x1*2000==map.points(j,2) && y1*2000==map.points(j,1)
                jj=j;
            end
        end
        for z=1:size(map.points,1)
            if x2*2000==map.points(z,1) && y2*2000==map.points(z,2) 
                zz=z;
            elseif x2*2000==map.points(z,2) && y2*2000==map.points(z,1)
                zz=z;
            end
        end
        mappp.lines=[mappp.lines; jj zz];

    end
end
% map.lines=unique(mappp.lines, 'rows');
map.lines=mappp.lines;

% Plot the map lines
for i=1:size(map.lines,1)
    x1=map.points(map.lines(i,1),1);
    y1=map.points(map.lines(i,1),2);
    x2=map.points(map.lines(i,2),1);
    y2=map.points(map.lines(i,2),2);

    x=[x1 x2];
    y=[y1 y2];
    hold on;
    plot(x, y, '-r','LineWidth',2);
end


max_x=max(map.points(:,1));
min_x=min(map.points(:,1));

max_y=max(map.points(:,2));
min_y=min(map.points(:,2));


lines=map.lines;

num_couples = 100;
couples = zeros(num_couples, 4);


polygons = cell(0); 
while ~isempty(lines)
    polygon = lines(1,:);
    lines(1,:) = [];
    while true
        next_idx = find(lines(:,1) == polygon(end), 1);
        if isempty(next_idx)
            next_idx = find(lines(:,2) == polygon(end), 1);
            if isempty(next_idx)
                break;
            end
            polygon = [polygon, lines(next_idx,1)];
        else
            polygon = [polygon, lines(next_idx,2)];
        end
        lines(next_idx,:) = [];
    end
    polygons{end+1} = map.points(polygon,:);
end


polygons(1) = [];


num_points = 0;
while num_points < num_couples
    x_start = rand * (max(map.points(:,1)) - min(map.points(:,1))) + min(map.points(:,1));
    y_start = rand * (max(map.points(:,2)) - min(map.points(:,2))) + min(map.points(:,2));
    x_goal = rand * (max(map.points(:,1)) - min(map.points(:,1))) + min(map.points(:,1));
    y_goal = rand * (max(map.points(:,2)) - min(map.points(:,2))) + min(map.points(:,2));
    
    inside_any_polygon = false;
    for k = 1:length(polygons)
        if inpolygon(x_start, y_start, polygons{k}(:,1), polygons{k}(:,2)) || inpolygon(x_goal, y_goal, polygons{k}(:,1), polygons{k}(:,2))
            inside_any_polygon = true;
            break;
        end
    end
    
    if ~inside_any_polygon
        num_points = num_points + 1;
        couples(num_points, :) = [x_start, y_start, x_goal, y_goal];
    end
end
function plotOnMap = pp_plotPathOnMap(paths)
    
    global nRobots;
    global pathColors;

    figure(1)
    for j=1:nRobots
        plot(paths{j}(1,1),paths{j}(1,2),'square','MarkerSize',7,'MarkerFaceColor',pathColors(j,:))
        plot(paths{j}(end,1),paths{j}(end,2),'square','MarkerSize',7,'MarkerFaceColor','r')
        text(paths{j}(1,1),paths{j}(1,2),num2str(j),'Color','black');

        x = paths{j}(:,1);
        y = paths{j}(:,2);
        plot(x, y,'-o','Color','k','MarkerSize',2,'LineWidth',1.5);
        disp("Plotting")
    end

end


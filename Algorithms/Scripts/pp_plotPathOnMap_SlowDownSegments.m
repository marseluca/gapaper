function plotOnMap = pp_plotPathOnMap_SlowDownSegments(edited_paths,x_opt,trajectories,style)
    
    global nRobots;
    global pathColors;

    figure(1)

    for j=1:nRobots

        d_i = x_opt(3*(j-1) + 1);


        plot(edited_paths{j}(1,1),edited_paths{j}(1,2),'square','MarkerSize',7,'MarkerFaceColor',pathColors(j,:))
        plot(edited_paths{j}(end,1),edited_paths{j}(end,2),'square','MarkerSize',7,'MarkerFaceColor','r')
        text(edited_paths{j}(1,1),edited_paths{j}(1,2),num2str(j),'Color','black');

        x = edited_paths{j}(:,1);
        y = edited_paths{j}(:,2);
        plot(x, y,'square','MarkerFaceColor',pathColors(j,:),'MarkerSize',2);
        
        if d_i==1
            for k=1:length(trajectories{j}.x_tot)
                if norm([trajectories{j}.x_tot(k),trajectories{j}.y_tot(k)]-[x(2),y(2)])<0.5
                    break;
                end
            end
            
            plot(trajectories{j}.x_tot(1:k),trajectories{j}.y_tot(1:k),'-','Color',pathColors(j,:),'LineWidth',2);
            plot(trajectories{j}.x_tot(k+1:end),trajectories{j}.y_tot(k+1:end),style,'Color',pathColors(j,:),'LineWidth',1); 
        else
            plot(trajectories{j}.x_tot,trajectories{j}.y_tot,style,'Color',pathColors(j,:),'LineWidth',1);
        end
    end


    set(gca,'XAxisLocation','top', 'box','off', 'XTick', [])
    set(gca,'YAxisLocation','left', 'box','off', 'YTick', [])
    xlabel("");
    ylabel("");
    axis tight;

end


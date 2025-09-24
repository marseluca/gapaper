function res = pp_plotRobotsClosestObstacles(trajectories,delta_s,markerStyle,when,plotRobotsClosestObstacles)

    global nRobots pathColors;

    if plotRobotsClosestObstacles

        for j=1:nRobots
            
            figure(1+j)
            hold on
            distances = [];

            for k=1:length(trajectories{j}.t_tot)
                
                minDistance = Inf;

                for i=1:nRobots
                    if j~=i && length(trajectories{i}.t_tot)>=k
                        distance = sqrt((trajectories{i}.x_tot(k) - trajectories{j}.x_tot(k)).^2 + (trajectories{i}.y_tot(k) - trajectories{j}.y_tot(k)).^2);
                        if distance<minDistance
                            minDistance = distance;
                        end
                    end
                end

                distances = [distances, minDistance];

            end
            
            plot(trajectories{j}.t_tot,distances,'LineWidth',1.2,'LineStyle',markerStyle,'Color',pathColors(j,:));
            hold on
            plot(trajectories{j}.t_tot,delta_s*ones(1,length(trajectories{j}.t_tot)),'-r');
            ylim([0 Inf]);

            if when=="After optimization"
                legend("Before optimization","","After optimization","Safety margin");
            end
            hold off
            grid on
            title("Distances of robot "+j+" from the closest obstacle"); 
            xlabel("t [s]")
            ylabel("$d(t)\:[m]$",'Interpreter','latex')

        end

    end
    
end

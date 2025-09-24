function plots = pp_producePlots(trajectories,delta_s,flag)
    
    global nRobots pathColors;
    
    if flag
        
        figure(2);
        hold on 

        if nRobots>1
            minDistances = pp_getMinimumDistances(trajectories);

            [~, maxLengthIndex] = max(arrayfun(@(i) length(trajectories{i}.x_tot), 1:nRobots));
            maxTimeStep = length(minDistances);
            timeSteps = trajectories{maxLengthIndex}.t_tot(1:maxTimeStep);
            
            plot(timeSteps, minDistances,'b-','LineWidth',1.2);
            xlabel('Time Step');
            ylabel('Minimum Distance');
            title('Minimum Distance at Each Time Step');

            ylim([0 Inf])
    
            hold on
            plot(timeSteps,delta_s*ones(1,length(minDistances)),':','LineWidth',1.2);
            xlabel("t [s]")
            ylabel("$d(t)\:[m]$",'Interpreter','latex')
            title("Minimum distance between robots")
            legend("","","Safety margin")
            grid
            hold off

            % PIE CHART
            
            % figure
            % 
            % [percentages,legendVec] = pp_plotPieChart(minDistances,delta_s);
            % p = piechart(percentages,legendVec);
            % legend;
            % p.LabelStyle = "percent";
            % title("Amount of d(t) samples in each multiple of the safety margin")
        end


        for j=1:nRobots

            figure(2+j)
            
            hold on
            subplot(2,2,1)
            sgtitle("Robot "+j)
    
            plot(trajectories{j}.t_tot,trajectories{j}.x_tot,'-','LineWidth',1.2,'Color',pathColors(j,:));
            xlabel("t [s]")
            ylabel("$x(t)\:[m]$",'Interpreter','latex')
            hold off
            grid on
    
            hold on
            subplot(2,2,2)
            plot(trajectories{j}.t_tot,trajectories{j}.y_tot,'-','LineWidth',1.2,'Color',pathColors(j,:));
            xlabel("t [s]")
            ylabel("$y(t)\:[m]$",'Interpreter','latex')
            hold off
            grid on

            velocity_magnitude = sqrt(trajectories{j}.xdot_tot.^2 + trajectories{j}.ydot_tot.^2);
            acceleration_magnitude = sqrt(trajectories{j}.xddot_tot.^2 + trajectories{j}.yddot_tot.^2);
    
            hold on
            subplot(2, 2, 3)
            plot(trajectories{j}.t_tot,velocity_magnitude,'-','LineWidth',1.2,'Color',pathColors(j,:));
            xlabel("t [s]")
            ylabel("$|v(t)|\:[m]$",'Interpreter','latex')
            ylim([0 1.5])
            hold off
            grid on

            hold on
            subplot(2, 2, 4)
            plot(trajectories{j}.t_tot,acceleration_magnitude,'-','LineWidth',1.2,'Color',pathColors(j,:));
            xlabel("t [s]")
            ylabel("$|a(t)|\:[m]$",'Interpreter','latex')
            ylim([0 1])
            hold off
            grid on

            % subplot(3, 2, 5)
            % % Plot individual components of velocity instead of magnitude
            % hold on
            % plot(trajectories{j}.t_tot, trajectories{j}.xdot_tot, 'LineWidth', 1.2, 'Color', 'r', 'DisplayName', 'a_x');
            % plot(trajectories{j}.t_tot, trajectories{j}.ydot_tot, 'LineWidth', 1.2, 'Color', 'b', 'DisplayName', 'a_y');
            % grid
            % ylim([-1.5 1.5]);
            % xlabel("t [s]")
            % ylabel("$v(t)\:[m/s]$",'Interpreter','latex')
            % % legend('v_x', 'v_y')
            % hold off
            % 
            % subplot(3, 2, 6)
            % % Plot individual components of acceleration instead of magnitude
            % hold on
            % plot(trajectories{j}.t_tot, trajectories{j}.xddot_tot, 'LineWidth', 1.2, 'Color', 'r', 'DisplayName', 'a_x');
            % plot(trajectories{j}.t_tot, trajectories{j}.yddot_tot, 'LineWidth', 1.2, 'Color', 'b', 'DisplayName', 'a_y');
            % grid
            % ylim([-1 1]);
            % xlabel("t [s]")
            % ylabel("$a(t)\:[m/s^2]$",'Interpreter','latex')
            % % legend('a_x', 'a_y')
            % hold off

            
        end

    end
    
end


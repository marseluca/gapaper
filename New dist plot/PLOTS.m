close all

% %% BOXCHART COMBINATIONS

% figure
% 
% allValues = [];
% genSteps = 5;
% maxGens = 500;
% nExecutions = size(allHistories{1},1);
% 
% % Puoi usare anche ndgrid
% CFMR = ["[0.3, 0.01]", "[0.3, 0.05]", "[0.3, 0.1]",...
%      "[0.6, 0.01]", "[0.6, 0.05]", "[0.6, 0.1]",...
%      "[0.9, 0.01]", "[0.9, 0.05]", "[0.9, 0.1]"];
% 
% for k=1:9
%     for i=1:genSteps
% 
%         for j=1:nExecutions
%             allValues(j,i) = allHistories{k}(j,i*maxGens/genSteps);
%         end
% 
%     end
% 
%     subplot(3,3,k)
%     boxchart(allValues)
%     title("[CF, MR] = "+CFMR(k))
%     xlabel("Generations")
%     ylabel("Best fit")
%     ylim([80 115])
%     set(gca,'XTickLabel',{"100","200","300","400","500"});
% 
%     grid on
% end
% 
% 
% sgtitle("Best fit histories ("+ nExecutions + " executions)")
% 
% % %% BARCHARTS FINAL VALUES
% % 
% figure
% medians = [97.8, 92.75, 92.95, 94.75, 90.35, 89.7, 89.9, 90.2, 89.7]';
% ranges = [7.8, 4.4, 5.9, 5.6, 4.1, 91.6, 1.8, 4.3, 5.8]';
% 
% nil = [0 0 0 0 0 0 0 0 0]';
% x = categorical(CFMR);
% 
% bar(x,[medians nil], 'grouped')
% ylabel('Median [s]');
% ylim([85 100]);
% 
% yyaxis right
% bar(x,[nil ranges], 'grouped')
% ylabel('IQR [s]');
% ylim([0 8]);
% 
% title("Median and IQR after 500 generations ("+nExecutions+" executions)");
% xlabel("[CF, MR]")
% grid
% set(gca,'XTickLabel',CFMR);


%% LINEPLOTS
figure

subplot(2,1,1)

nExecutions = size(allHistories,1);

for j=1:nExecutions
    plot(allHistories(j,:),'LineWidth',1.2);
    hold on
end

xlabel("Generations")
ylabel("Best fit [s]")
xlim([0 510])
ylim([75 140])

grid on
hold off


%% BOXCHARTS SINGLE PARAMETERS

% figure
subplot(2,1,2)

genSteps = 5;
maxGens = 500;

for i=1:genSteps

    for j=1:nExecutions
        allValues(j,i) = allHistories(j,i*maxGens/genSteps);
    end

end

boxchart(allValues)
xlabel("Generations")
ylabel("Best fit [s]")
ylim([80 115])
set(gca,'XTickLabel',{"100","200","300","400","500"});
% title("Best fit histories with [CF, MR] = [0.9, 0.01] ("+nExecutions+" executions)");

grid on

sgtitle("Best fit histories with 100 individuals ("+50+" executions)")
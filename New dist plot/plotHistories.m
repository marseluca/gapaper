close all

step = 200;

for i=1:5
    population = i*step;
    plot(histories_new{i},'LineWidth',1.2,'DisplayName',num2str(population) + " individuals");
    hold on
end
legend("200 individuals","400 individuals","600 individuals","800 individuals","1000 individuals")
title("Best fit history")
xlabel("Generations")
ylabel("Best fit")

grid on
hold off

figure

bestFits = [];
population = [];
for i=1:5
    population = [population, i*step];
    bestFits = [bestFits, histories_middle{i}(end)];
end
bar(population,bestFits)
grid on
title("Best fits after 100 generations")
xlabel("Population [individuals]")
ylabel("Best fit")

hold on

bestFits = [];
population = [];
for i=1:5
    population = [population, i*step];
    bestFits = [bestFits, histories_new{i}(end)];
end
bar(population,bestFits)


figure
bar(1000,93);

hold on 

bar(1000,executions_middle(end)/60/5)
grid on
title("Execution time after 100 generations")
xlabel("Population [individuals]")
ylabel("Execution time [m]")

hold on

bar(1000,executions_new(end)/60)

legend("Starting execution time","First optimization","Second optimization");
text(1:length(Y),Y/2,num2str(Y'),'vert','bottom','horiz','center');  % values position
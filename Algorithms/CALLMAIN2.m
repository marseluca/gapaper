
global maxGen popSize crossoverFraction mutationRate;
global feasibleSolution validSim;

addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\SOO Maximum Velocities")

maxGen = 500;
popSize = 100;
crossoverFraction = 0.9;
mutationRate = 0.01;

allFeasibleSolutions = [];
numberOfValidSimulations = 0;
totalSimulations = 0;

while numberOfValidSimulations<50
        
    fprintf("[%s] Valid simulations: %d/%d\n",datestr(now,'HH:MM'),numberOfValidSimulations,totalSimulations)
    
    feasibleSolution;

    pp_main;

    if validSim
        numberOfValidSimulations = numberOfValidSimulations+1;
        allFeasibleSolutions = [allFeasibleSolutions; feasibleSolution];
        fprintf("Valid simulation found\n")
        save("opt_data7.mat","allFeasibleSolutions");
    end

    totalSimulations = totalSimulations+1;
    
end

global maxGen popSize crossoverFraction mutationRate;
global feasibleSolution validSim;

maxGen = 500;
popSize = 100;
crossoverFraction = 0.9;
mutationRate = 0.1;

allFeasibleSolutions = [];
numberOfValidSimulations = 0;
totalSimulations = 0;

while numberOfValidSimulations<33
        
    fprintf("[%s] Valid simulations: %d/%d\n",datestr(now,'HH:MM'),numberOfValidSimulations,totalSimulations)
    
    feasibleSolution;

    SOO;

    if validSim
        numberOfValidSimulations = numberOfValidSimulations+1;
        allFeasibleSolutions = [allFeasibleSolutions; feasibleSolution];
        fprintf("Valid simulation found\n")
        save("opt_data9plus.mat","allFeasibleSolutions");
    end

    totalSimulations = totalSimulations+1;
    
end
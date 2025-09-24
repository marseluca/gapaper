% addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\Scripts");
% addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\Scripts\Interpolators"); 
addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\SOO Maximum Velocities");
addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\SOO Maximum Velocities\Interpolators");
close all

paths = {};
paths = load("C:\Users\Luca\Desktop\Thesis\paths_registration.mat").paths_registration;

CFMR = ["[0.3, 0.01]", "[0.3, 0.05]", "[0.3, 0.1]",...
        "[0.6, 0.01]", "[0.6, 0.05]", "[0.6, 0.1]",...
        "[0.9, 0.01]", "[0.9, 0.05]", "[0.9, 0.1]"];

global nRobots maxVelocity maxAcceleration samplingTime;

nRobots = size(paths,2);
maxVelocity = 1.5;
maxAcceleration = 1;
samplingTime = 0.1;

allMeanDistances = cell(1,9);
allMinDistances = cell(1,9);
figure

for k=1:9
    fprintf("Iter: %d\n",k)

    feasiblePoints = allSolutions{k};
    meanDistancesVector = [];
    minDistancesVector = [];

    subplot(3,3,k)
    title("[CF, MR] = "+CFMR(k))
    hold on

    for i=1:size(feasiblePoints,1)

        x_opt = feasiblePoints(i,:);

        % trajectories = pp_modifyTrajectories(x_opt,paths);
        for j=1:nRobots
            trajectories{j} = pp_interpolatePath2(paths{j},x_opt(j),0,0);
        end

        minDistances = pp_getMinimumDistances(trajectories);
        meanDistance = sum(minDistances)/length(minDistances);
        meanDistancesVector = [meanDistancesVector; meanDistance];
        minDistancesVector = [minDistancesVector; min(minDistances)];

        [~, maxLengthIndex] = max(arrayfun(@(i) length(trajectories{i}.x_tot), 1:nRobots));
        maxTimeStep = length(minDistances);
        timeSteps = trajectories{maxLengthIndex}.t_tot(1:maxTimeStep);
        plot(timeSteps,minDistances)
        plot(timeSteps,2*ones(1,length(minDistances)),'--')
        xlabel("t [s]")
        ylabel("$d(t)\:[m]$",'Interpreter','latex')
    end

    % allMeanDistances{k} = sum(meanDistancesVector)/length(meanDistancesVector);
    allMeanDistances{k} = median(meanDistancesVector);
    allMinDistances{k} = median(minDistancesVector);
    grid
end

sgtitle({"Minimum distances between robots for the","Maximum velocities approach (50 executions)"})
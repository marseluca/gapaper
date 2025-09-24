%% TRAJECTORY COMPUTATION

close all
global nRobots samplingTime maxVelocity maxAcceleration;
global paths delta_s; 


% openfig("warehouse.fig");
paths = {};
paths = load("C:\Users\Luca\Desktop\Thesis\paths_registration.mat").paths_registration;
addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\Scripts");
addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\Scripts\Interpolators");
addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\MOO_opt_functions");

nRobots = size(paths,2);

for j=1:nRobots
    paths{j} = unique(paths{j},'rows','stable');
end

%% VARIABLES
robotSize = 1;
delta_s = 2;
collisionThreshold = delta_s;
maxVelocity = 1.5;
maxAcceleration = 1;

samplingTime = 0.1;


for k=1:9

    allParetoPoints{k} = [];

    for i=1:size(filteredPoints{k},1)

        x_opt = filteredPoints{k}(i,:);

        trajectories = pp_modifyTrajectories(x_opt,paths);

        finishTimes = [];
        for j=1:nRobots
            finishTimes = [finishTimes, trajectories{j}.t_tot(end)];
        end

        finishTime = max(finishTimes);
        
        totalEnergy = pp_computeEnergy(trajectories);

        allParetoPoints{k} = [allParetoPoints{k}; finishTime totalEnergy];

    end

end
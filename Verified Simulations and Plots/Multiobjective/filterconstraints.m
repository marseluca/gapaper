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


%% INTERPOLATION
trajectories = {};
for j=1:nRobots
    trajectories{j} = pp_interpolatePath2(paths{j},0,0);
end

filteredPoints = cell(1,9);
for k=1:9
    filteredPoints{k} = [];
    for i=1:50
        currentArray = cell2mat(allFeasibleParetoPoints(k,i));

        for n=1:size(currentArray,1)

            x_opt = currentArray(n,:);
            
            constraintvalue = o_collision_constraint(x_opt,paths,delta_s);

            if constraintvalue<0
                filteredPoints{k} = [filteredPoints{k}; x_opt];
                fprintf("Current iter: %d/%d/%d, Constraint: %d\n",k,i,n,constraintvalue)
            end
            
        end

    end

end
paths = {};
paths = load("C:\Users\Luca\Desktop\Thesis\paths_registration.mat").paths_registration;
addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\Scripts\Interpolators");

global nRobots maxVelocity maxAcceleration samplingTime;

nRobots = size(paths,2);
maxVelocity = 1.5;
maxAcceleration = 1;
samplingTime = 0.1;


x_opt = [1.5 1.3 1.5 1.2 0.9 0.9 1.5];

% trajectories = pp_modifyTrajectories(x_opt,paths);

for j=1:nRobots
    trajectories{j} = pp_interpolatePath2(paths{j},x_opt(j),0,0);
end

minDistances = pp_getMinimumDistances(trajectories);
meanDistance = sum(minDistances)/length(minDistances)
minDistance = min(minDistances)

  
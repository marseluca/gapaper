%% TRAJECTORY COMPUTATION

clc
clear all
% close all
global nRobots samplingTime pathColors maxVelocity maxAcceleration;

openfig("warehouse.fig");
paths = {};
paths = load("C:\Users\Luca\Desktop\Collaborative path\paths_registration.mat").paths_registration;

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

%% OPTIONS
animation = false;
animVelocity = 7;
recordAnimation = true;
solveCollisions = true;
plotVelocities = true;
plotCollisions = false;

samplingTime = 0.1;

% Create random path colors
pathColors = distinguishable_colors(nRobots);


%% INTERPOLATION
trajectories = {};
for j=1:nRobots
    trajectories{j} = pp_interpolatePath2(paths{j},maxVelocity,0,0);
end


%% COLLISION CHECKING
collisions = {};
for j=1:nRobots
    collisions{j} = pp_checkCollisionForOneRobot(paths,trajectories,collisionThreshold,j);
end


if plotCollisions
    pp_plotCollisions(collisions,trajectories);
end

finishTimes = [];
for j=1:nRobots
    finishTimes = [finishTimes, trajectories{j}.t_tot(end)];
end
finishTimes




%% COLLISION SOLVING

if ~isempty(collisions) && solveCollisions
    
    optimizedVector = pp_collisionFreeVelocities1(paths,collisionThreshold);
    % optimizedVector = pp_collisionFreeVelocities2(paths,collisionThreshold);
    
    
    % optimizedVector = load("optimizedVector.mat").optimizedVector;

    for j=1:nRobots
        vmax = optimizedVector(j);
        trajectories{j} = pp_interpolatePath2(paths{j},vmax,0,0);
    end
    
end


pp_plotPathOnMap(paths,trajectories,'-');

if plotVelocities
    % Plot positions, velocities and accelerations
    pp_producePlots(trajectories,delta_s,plotVelocities);
end

%% ANIMATION
if animation
    fprintf("\nPress enter to record animation with velocity %dx...\n",animVelocity);
    pp_animateTrajectory(trajectories,robotSize,recordAnimation,animVelocity);
end

total_energy_consumption = pp_computeEnergy(trajectories)

% save("optimizedVector.mat","optimizedVector");

% figure(1)
% saveas(gcf,'warehouse.png')
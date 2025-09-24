%% TRAJECTORY COMPUTATION

warning('off','all')

clear all
close all
global nRobots samplingTime pathColors maxAcceleration paths delta_s;

% Add the "Interpolators" folder to the path
% Contain the compiled MEX file of the interpolation functi
addpath("Interpolators");

openfig("warehouse.fig");
paths = {};
paths = load("C:\Users\Luca\Uni\Thesis\Algorithms\Scripts\paths_registration.mat").paths_registration;

nRobots = size(paths,2);

for j=1:nRobots
    paths{j} = unique(paths{j},'rows','stable');
end

%% VARIABLES
robotSize           = 1;
delta_s             = 2;
collisionThreshold  = delta_s;
maxVelocity         = 1.5;
maxAcceleration     = 1;

%% OPTIONS
animation           = true;
animVelocity        = 7;
recordAnimation     = true;
solveCollisions     = true;
preloadOptimization = true;
plotVelocities      = true;
plotCollisions      = false;

samplingTime        = 0.1;

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


%% COLLISIONS
if solveCollisions

    if preloadOptimization==false

        % Lower and upper bounds for the max velocity
        lb = [];
        ub = [];
    
        for i = 1:nRobots
            lb = [lb, 0.1];
            ub = [ub, maxVelocity];
        end
        
        % Set the options for the genetic algorithm
        global maxGen;
        maxGen = 100;

        options_ga = optimoptions('ga', ...
        'Display', 'final', ...
        'PopulationSize', 100, ....
        'NonlinearConstraintAlgorithm', 'penalty', ...
        'CrossoverFraction', 0.6, ...
        'MutationFcn', {@mutationuniform, 0.1}, ...
        'MaxStallGenerations',1000,...
        'OutputFcn', @o_outputFcn3);
    
        % Call the ga solver    
        objectiveFun = @(x) o_objective(x,paths);
        constraintFun = @(x) o_collision_constraint(x,paths,delta_s);
        
        [x_opt, fval] = ga(objectiveFun, nRobots, [], [], [], [], lb, ub, constraintFun, options_ga);
    else
        x_opt = [1.3 1.11 1.5 1.13 0.75 1.44 0.75];
    end

end

%% APPLY THE OPTIMIZED SOLUTION
for j=1:nRobots
    trajectories{j} = pp_interpolatePath2(paths{j},x_opt(j),0,0);
end

pp_plotPathOnMap(paths,trajectories,'-');
pp_plotMinCouples(trajectories);

if plotVelocities
    % Plot positions, velocities and accelerations
    pp_producePlots(trajectories,delta_s,plotVelocities);
end

%% ANIMATION
if animation
    fprintf("\nPress enter to record animation with velocity %dx...\n",animVelocity);
    pp_animateTrajectory(trajectories,robotSize,recordAnimation,animVelocity);
end

totalEnergy = pp_computeEnergy(trajectories);

% figure(1)
% saveas(gcf,'warehouse.png')

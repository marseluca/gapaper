%% TRAJECTORY COMPUTATION

% clc
% clear all
close all
global nRobots samplingTime pathColors maxVelocity maxAcceleration;
global executionTime paretoFront feasibleParetoPoints maxGen popSize crossoverFraction mutationRate;
global paths delta_s;
maxGen = 500;
popSize = 100;
crossoverFraction = 0.9;
mutationRate = 0.1;


addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\Scripts");
addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\Scripts\Interpolators"); % Contains MEX-files to speed up execution
addpath("C:\Users\Luca\Desktop\Thesis\Algorithms\MOO_opt_functions");


% openfig("warehouse.fig");
paths = {};
paths = load("C:\Users\Luca\Desktop\Thesis\paths_registration.mat").paths_registration;

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
preloadOptimization = false;
plotVelocities = false;
plotCollisions = false;

samplingTime = 0.1;

% Create random path colors
pathColors = distinguishable_colors(nRobots);


%% INTERPOLATION
trajectories = {};
for j=1:nRobots
    % Versione precedente: senza limitazione di accelerazione
    % trajectories{j} = pp_interpolatePath(paths{j},maxVelocity,0,0);
    trajectories{j} = pp_interpolatePath2(paths{j},0,0);
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
% finishTimes


%% COLLISIONS
tic
if ~all(cellfun(@isempty,collisions)) && solveCollisions

    if preloadOptimization==false
    
    global x_opt;

    % Set ub and lb
    lb = [];
    ub = [];

    for i = 1:nRobots
        % Lower bounds for d_i, L_s, and alpha
        lb = [lb, 0, 0, 0.1];

        % Calculate the upper bound for L_s based on segments
        max_Ls = norm(paths{i}(2,:) - paths{i}(1,:)); % Length of the first segment

        % Upper bounds for d_i (binary), L_s (max segment length), and alpha
        ub = [ub, 1, max_Ls, 1];
    end

    % Set the integer constraints for d_i
    intcon = 1:3:(3*nRobots); % Indices for d_i

    % Set optimization options
    % Set the options for the genetic algorithm
    options_ga = optimoptions('gamultiobj', ...
    'Display', 'iter', ...
    'MaxGenerations', maxGen, ...
    'PopulationSize', popSize, ...
    'CrossoverFraction', crossoverFraction, ...
    'MutationFcn', {@mutationuniform, mutationRate},...
    'PlotFcn', [], ... % Use a different plot function suitable for multi-objective
    'MaxStallGenerations', 1000, ...
    'OutputFcn', @o_saveParetoFront); % If you want to use a similar concept for multi-objective

    % Call the ga solver

    objectiveFun = @(x) o_objective(x,paths);
    constraintFun = @(x) o_collision_constraint(x,paths,delta_s);
    
    tic
    [x_opt, fval] = gamultiobj(objectiveFun, 3*nRobots, [], [], [], [], lb, ub, constraintFun, intcon, options_ga);
    executionTime = toc;
    
    else
        x_opt = [1	5.94928166295775	0.381249981749900	1	36.1002226068165	0.718754540310564	1	0.205566041246347	0.614144038317734	1	1.90553632129219	0.516918307372906	1	31.2866031991704	0.316528722347503	1	1.50843979826840	0.742512004105806	1	8.54289574143515	0.943750000000000];
    end
end

% trajectories = pp_modifyTrajsectories(x_opt,paths);

% pp_plotPathOnMap(paths,trajectories,'-');

if plotVelocities
    % Plot positions, velocities and accelerations
    pp_producePlots(trajectories,delta_s,plotVelocities);
end

%% ANIMATION
if animation
    fprintf("\nPress enter to record animation with velocity %dx...\n",animVelocity);
    pp_animateTrajectory(trajectories,robotSize,recordAnimation,animVelocity);
end

% figure(1)
% saveas(gcf,'warehouse.png')





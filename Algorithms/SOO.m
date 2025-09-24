%% TRAJECTORY COMPUTATION

clear all
close all

global nRobots samplingTime pathColors maxVelocity maxAcceleration paths delta_s;


addpath("C:\Users\Luca\Desktop\finalthesis\Algorithms\Scripts");
addpath("C:\Users\Luca\Desktop\finalthesis\Algorithms\Scripts\Interpolators"); % Contains MEX-files to speed up execution
addpath("C:\Users\Luca\Desktop\finalthesis\Algorithms\SOO_opt_functions");


openfig("warehouse.fig");
paths = {};
paths = load("C:\Users\Luca\Desktop\finalthesis\paths_registration.mat").paths_registration;

nRobots = size(paths,2);

for j=1:nRobots
    paths{j} = unique(paths{j},'rows','stable');
end
edited_paths = paths;

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
    % Versione precedente: senza limitazione di accelerazione
    % trajectories{j} = pp_interpolatePath(paths{j},maxVelocity,0,0);
    trajectories{j} = pp_interpolatePath3(paths{j},0,0);
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
if solveCollisions

    if preloadOptimization==false
    
        % Lower and upper bounds for d_i, L_s, and alpha
        lb = [];
        ub = [];
    
        for i = 1:nRobots
            
            lb = [lb, 0, 0, 0.1];

            % Length of the first segment
            max_Ls = norm(paths{i}(2,:) - paths{i}(1,:)); 
    
            ub = [ub, 1, max_Ls, 1];
        end
    
        % Set the integer constraints for d_i
        intcon = 1:3:(3*nRobots);
    
        % Set the options for the genetic algorithm
        global maxGen;
        maxGen = 500;

        options_ga = optimoptions('ga', ...
        'Display', 'final', ...
        'MaxGenerations', maxGen, ...
        'PopulationSize', 100, ...
        'CrossoverFraction', 0.6, ...
        'MutationFcn', {@mutationuniform, 0.1},...
        'NonlinearConstraintAlgorithm', 'penalty', ...
        'MaxStallGenerations', 1000);
    
        % Call the ga solver
    
        objectiveFun = @(x) o_objective(x,paths);
        constraintFun = @(x) o_collision_constraint(x,paths,delta_s);
        
        tic
        [x_opt,fval,exitflag,output,population,scores] = ga(objectiveFun, 3*nRobots, [], [], [], [], lb, ub, constraintFun, intcon, options_ga);    
        o_finalOutput(population,scores);
        toc
    else

        x_opt = [1 20.48 0.6 0 30.68 0.41 1 10.08 0.7 1 38.97 0.86 1 18.69 0.43 0 5.53 0.51 1 2.66 0.34];

        %% APPLY THE OPTIMIZED SOLUTION
        for i=1:nRobots
            d_i = x_opt(3*(i-1) + 1); % Decision variable for robot i
            L_s = x_opt(3*(i-1) + 2); % Length of slow-down segment for robot i
            alpha = x_opt(3*(i-1) + 3); % Velocity scaling factor for robot i
        
            path = paths{i};
            if d_i == 1
                newSegment = 1;
                path = pp_addNewSegment(path, newSegment, 0, L_s);
                path = unique(path, 'rows', 'stable');
                trajectories{i} = pp_interpolatePath3(path, newSegment, alpha);
                edited_paths{i} = path;
            else
                trajectories{i} = pp_interpolatePath3(path, 0, 0);
            end    
        end

    end
end

if preloadOptimization
    pp_plotPathOnMap_SlowDownSegments(edited_paths,x_opt,trajectories,'-');
    
    if plotVelocities
        % Plot positions, velocities and accelerations
        pp_producePlots(trajectories,delta_s,plotVelocities);
        
    end
    
    %% ANIMATION
    if animation
        fprintf("\nPress enter to record animation with velocity %dx...\n",animVelocity);
        pp_animateTrajectory(trajectories,robotSize,recordAnimation,animVelocity);
    end
end





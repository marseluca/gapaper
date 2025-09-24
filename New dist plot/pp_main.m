%% TRAJECTORY COMPUTATION

close all
global nRobots samplingTime pathColors maxVelocity maxAcceleration;
global paths delta_s; 
openfig("warehouse.fig");
paths = {};
paths = load("paths_registration.mat").paths_registration;

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
plotcase = false;

samplingTime = 0.1;

% Create random path colors
pathColors = distinguishable_colors(nRobots);

%% INTERPOLATION
trajectories = {};
for j=1:nRobots
    trajectories{j} = pp_interpolatePath2(paths{j},maxVelocity,0,0);
end

if plotcase 
    
    x_opt = [1	5.94928166295775	0.381249981749900	1	36.1002226068165	0.718754540310564	1	0.205566041246347	0.614144038317734	1	1.90553632129219	0.516918307372906	1	31.2866031991704	0.316528722347503	1	1.50843979826840	0.742512004105806	1	8.54289574143515	0.943750000000000];

    % Add the optimized segments
    trajectories = pp_modifyTrajectories(x_opt,paths);
end
% 
pp_plotMinCouples(trajectories);







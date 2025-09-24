clear all
close all

% DT_RRTstar_opc_sequence_multiplepoints_warehouse_MultipleRobots

global addLines;
addLines = false;
global addedLines;
% addedLines = [19 51; 24 25; 21 20; 52 26];
global triangulation;

global startPoints;
startPoints = [-400, 8; -600, 950; -400, 500; 600, 300; 600, 950; 600, 100];

pp_executeDTRRTstar;
% DT_RRTstar_opc_sequence_multiplepoints_warehouse_MR_prob_m

paths = paths_registration;

global nRobots;
nRobots = size(paths,2);

% Create random path colors
global pathColors;
pathColors = load("pathColors.mat").pathColors;

%% START

% Start from the last triangle
% WARNING: "currentTriangleIndex" is already used by the triangulation functions
currTriangleIndex = visitedTrianglesSequences{1}(end);
previousTriangleIndex = 0;

for k=1:5

    % Find adjacent triangles
    adjTriangles = pp_findAdjacentTriangles(currTriangleIndex);

    % Create the array for the candidate triangles
    % To be selected as the next triangle
    selectableTriangles = adjTriangles;

    % After the first iteration, remove the previous triangle from the
    % selectable triangles
    if k>1
        selectableTriangles(selectableTriangles==previousTriangleIndex) = [];
    end

    % Create the array of visited triangles for all the paths
    allSequences = [];
    for j=1:nRobots
        allSequences = [allSequences; visitedTrianglesSequences{j}];
    end

    for j=1:length(adjTriangles)

        % If the adjacent triangle does not contain any path
        if ~ismember(adjTriangles(j),allSequences')

            % Remove it from the selectable triangles
            selectableTriangles(selectableTriangles==adjTriangles(j)) = [];

            % But also add an obstacle if it is not already an obstacle
            pp_addObstacleToEmptyTriangle(currTriangleIndex,adjTriangles(j),map.lines,k);

        end

    end

    % Select the next triangle as the one that contains more paths
    selectedTriangle = pp_selectNextTriangle(currTriangleIndex,selectableTriangles,visitedTrianglesSequences,map.lines);


    % Add the obstacles to the excluded triangles
    pp_addObstacleToExcludedTriangles(currTriangleIndex,selectedTriangle,selectableTriangles);

    if ~isempty(addLines)
        addLines = true;
    end
    pp_executeDTRRTstar

    % Update the current triangle index
    % fprintf("\n\nSelected index: %d, Current index: %d\n\n",selectedTriangle,currentTriangleIndex)
    previousTriangleIndex = currTriangleIndex;
    currTriangleIndex = selectedTriangle;
end


paths = paths_registration;
pp_plotPathOnMap(paths);
%% COMBINATIONS

maxRetries = 100; % Define the maximum number of retries

for attempt = 1:maxRetries

    try

        global maxGen popSize crossoverFraction mutationRate bestFitHistory constraintHistory totalEnergy executionTime;

        allFitHistories = {};
        allConstHistories = {};
        allExecutionHistories = {};
        allEnergyHistories = {};



        maxItr = 50;
        maxGen = 500;
        popSize = 100;
        CF = [0.3 0.6 0.9];
        MR = [0.01 0.05 0.1];

        for i=1:9
            allFitHistories{i} = zeros(maxItr,maxGen+1);
            allConstHistories{i} = zeros(maxItr,maxGen+1);
            allExecutionHistories{i} = zeros(maxItr,1);
            allEnergyHistories{i} = zeros(maxItr,1);
        end


        for itr=1:maxItr

            iteration = 1;

            for ii=1:length(CF)

                for jj=1:length(MR)

                    if CF(ii)==0.9 && MR(jj)==0.1
                        continue;
                    end

                    fprintf("[%s] Iteration: %d, Combination: %d/9",datestr(now, 'HH:MM'),itr,iteration)

                    crossoverFraction = CF(ii);
                    mutationRate = MR(jj);

                    bestFitHistory = [];
                    constraintHistory = [];
                    totalEnergy = [];
                    executionTime = [];


                    pp_main;

                    allFitHistories{iteration}(itr,:) = bestFitHistory;
                    allConstHistories{iteration}(itr,:) = constraintHistory;

                    allFitHistories{iteration}(itr,:) = bestFitHistory;
                    allConstHistories{iteration}(itr,:) = constraintHistory;
                    allExecutionHistories{iteration}(itr,1) = executionTime;
                    allEnergyHistories{iteration}(itr,1) = totalEnergy;

                    save("opt_data"+num2str(attempt)+".mat","allFitHistories","allConstHistories","allExecutionHistories","allEnergyHistories");


                    iteration = iteration + 1;

                end

            end

            save("opt_data"+num2str(attempt)+".mat","allConstHistories","allFitHistories");

        end

        % save("opt_data.mat","allPopulations","allGenerations","allHistories","allExecutions")
        disp("Results saved in opt_data.mat")

        break; % Exit loop if successful

    catch ME
        disp(['Attempt ', num2str(attempt), ' failed: ', ME.message]);
        if attempt == maxRetries
            disp('Reached maximum retries. Stopping.');
        else
            pause(1); % Optional pause before retrying
        end
    end
end


% %% COMBINATIONS ONLY WITH MUTATION
% maxRetries = 30; % Define the maximum number of retries
% 
% for attempt = 1:maxRetries
% 
%     try
% 
%         global maxGen popSize crossoverFraction mutationRate bestFitHistory constraintHistory;
% 
%         allFitHistories = {};
%         allConstHistories = {};
% 
%         maxItr = 50;
%         maxGen = 500;
%         popSize = 100;
%         MR = [0.2 0.3 0.4];
% 
%         for i=1:9
%             allFitHistories{i} = zeros(maxItr,maxGen+2);
%             allConstHistories{i} = zeros(maxItr,maxGen+2);
%         end
% 
%         for itr=1:maxItr
% 
%             iteration = 1;
% 
%             for ii=1:length(MR)
% 
%                 fprintf("Iteration: %d, Combination: %d/3",itr,iteration)
% 
%                 crossoverFraction = 0.9;
%                 mutationRate = MR(ii);
% 
%                 bestFitHistory = [];
%                 constraintHistory = [];
% 
%                 pp_main;
% 
%                 allFitHistories{iteration}(itr,:) = bestFitHistory;
%                 allConstHistories{iteration}(itr,:) = constraintHistory;
% 
%                 iteration = iteration + 1;
% 
%             end
% 
%             save("opt_data"+num2str(attempt)+".mat","allFitHistories","allConstHistories");
% 
%         end
% 
%         save("opt_data.mat","allPopulations","allGenerations","allHistories","allExecutions")
%         disp("Results saved in opt_data.mat")
% 
%         break; % Exit loop if successful
% 
%     catch ME
%         disp(['Attempt ', num2str(attempt), ' failed: ', ME.message]);
%         if attempt == maxRetries
%             disp('Reached maximum retries. Stopping.');
%         else
%             pause(1); % Optional pause before retrying
%         end
%     end
% end

% SINGLE EXECUTIONS

maxRetries = 100; % Define the maximum number of retries
allFitHistories = {};
allConstHistories = {};

for attempt = 1:maxRetries

    try

        global maxGen popSize crossoverFraction mutationRate bestFitHistory constraintHistory totalEnergy executionTime; 

        maxItr = 50;
        maxGen = 500;
        popSize = 100;
        crossoverFraction = 0.9;
        mutationRate = 0.1;

        allFitHistories = zeros(maxItr,maxGen+1);
        allConstHistories = zeros(maxItr,maxGen+1);
        allExecutionHistories = zeros(maxItr,1);
        allEnergyHistories = zeros(maxItr,1);

        for itr=1:maxItr

            fprintf("[%s] Iteration: %d/%d",datestr(now, 'HH:MM'),itr,maxItr)

            bestFitHistory = [];
            constraintHistory = [];
            totalEnergy = [];
            executionTime = [];

            pp_main;

            allFitHistories(itr,:) = bestFitHistory;
            allConstHistories(itr,:) = constraintHistory;
            allExecutionHistories(itr,1) = executionTime;
            allEnergyHistories(itr,1) = totalEnergy;

            save("opt_data"+num2str(attempt)+".mat","allFitHistories","allConstHistories","allExecutionHistories","allEnergyHistories");

        end

        % save("opt_data.mat","allPopulations","allGenerations","allHistories","allExecutions")
        disp("Results saved in opt_data.mat")

        break; % Exit loop if successful

    catch ME
        disp(['Attempt ', num2str(attempt), ' failed: ', ME.message]);
        if attempt == maxRetries
            disp('Reached maximum retries. Stopping.');
        else
            pause(1); % Optional pause before retrying
        end
    end
end


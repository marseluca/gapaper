function [percentagesVec,legendVec] = pp_plotPieChart(minDistances,delta_s)

    maxDistance = max(minDistances(minDistances~=Inf));
    percentages = cell(1,ceil(maxDistance / delta_s));

    for j=1:length(minDistances)
        
        if minDistances(j)~=Inf
            % Note: the margin 0.01 is to correct small numerical errors
            % that cause data to fall in the interl 0<x<delta_s
            col = floor(minDistances(j)/(delta_s-0.01))+1;
            
            if col<=size(percentages,2)
                percentages{col} = [percentages{col}, minDistances(j)];
            end
        end

    end

    percentagesVec = [];
    legendVec = [];
    for j=1:length(percentages)
        percentagesVec(j) = length(percentages{j});
        legend = strcat(num2str(j-1)," < d(t) < ",num2str(j));
        legendVec = [legendVec, legend];
    end
    
end

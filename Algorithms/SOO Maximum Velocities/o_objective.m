function total_cost = o_objective(x,paths)

    global nRobots;

    total_cost = 0;

    for i = 1:nRobots

        slowedTraj = pp_interpolatePath2(paths{i}, x(i), 0, 0);  
        travel_time = slowedTraj.t_tot(end);
        total_cost = max(total_cost, travel_time);

    end
   
end
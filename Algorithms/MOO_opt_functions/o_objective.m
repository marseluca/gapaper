function total_cost = o_objective(x,paths)

    global maxVelocity nRobots;

    total_travel_time = 0;
    total_energy_consumption = 0;

    for i = 1:nRobots
        d_i = x(3*(i-1) + 1); % Decision variable for robot i
        L_s = x(3*(i-1) + 2); % Length of slow-down segment for robot i
        alpha = x(3*(i-1) + 3); % Velocity scaling factor for robot i

        % Get the path for robot i
        path = paths{i};
        if d_i == 1
            newSegment = 1;
            path = pp_addNewSegment(path, newSegment, 0, L_s);
            path = unique(path, 'rows', 'stable');
            slowedTraj = pp_interpolatePath2(path,newSegment,alpha);
        else
            slowedTraj = pp_interpolatePath2(path,0,0);
        end        

        % Calculate travel time for robot i
        travel_time = slowedTraj.t_tot(end);

        total_travel_time = max(total_travel_time, travel_time);

        % Calculate energy consumption for robot i
        m_i = 1000;
        v_i = sqrt(slowedTraj.xdot_tot.^2 + slowedTraj.ydot_tot.^2);
        a_i = abs(diff([0, v_i]));   % Approximate acceleration using differences
        t_i = slowedTraj.t_tot; % Time at each step
        delta_t = diff(t_i); % Delta t between each time step

        energy_i = m_i * sum(a_i(1:end-1) .* v_i(1:end-1) .* delta_t); % Energy for robot i (kJ)

        total_energy_consumption = total_energy_consumption + energy_i;
    end

    % Combine travel time and energy with weights lambda1 and lambda2
    lambda1 = 1;
    lambda2 = 1;
    total_cost = [lambda1 * total_travel_time; lambda2 * total_energy_consumption];

    
end
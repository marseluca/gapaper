function total_energy_consumption = pp_computeEnergy(trajectories)
    
    global nRobots;
    total_energy_consumption = 0;
    
    for j=1:nRobots
        % Calculate energy consumption for robot i
        m_i = 1000;
        v_i = sqrt(trajectories{j}.xdot_tot.^2 + trajectories{j}.ydot_tot.^2);
        a_i = abs(diff([0, v_i]));   % Approximate acceleration using differences
        t_i = trajectories{j}.t_tot; % Time at each step
        delta_t = diff(t_i); % Delta t between each time step

        energy_i = m_i * sum(a_i(1:end-1) .* v_i(1:end-1) .* delta_t); % Energy for robot i (kJ)

        total_energy_consumption = total_energy_consumption + energy_i;
    end
end


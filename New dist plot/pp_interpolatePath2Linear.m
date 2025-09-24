function trajectory = pp_interpolatePath2Linear(path)
    
    global maxVelocity maxAcceleration;

    % define waypoints
    t = 1:length(path);

    x = path(:,1);
    y = path(:,2);

    % calculate spline for way points

    tq = 0:(length(path)/120):length(path);
    
    
    %% Remove the first and last segment
    trajectory.x_tot = interp1(t,x,tq,'linear');
    trajectory.y_tot = interp1(t,y,tq,'linear');
    trajectory.t_tot = tq;
    %%

end

function helperPlotConstrainedTrajectory(q,t,limits,name)
    figure
    title([name + " vs Sample Time"])
    ylim("padded")
    hold on
    plot(t,q(1,:)) % X Value
    plot(t,q(2,:)) % Y Value
    plot(t,q(3,:)) % Z Value
    yline(limits(1,:),LineStyle="--",Color=[0.0000 0.4470 0.7410]) % X Limit
    yline(limits(2,:),LineStyle="--",Color=[0.8500 0.3250 0.0980]) % Y Limit
    yline(limits(3,:),LineStyle="--",Color=[0.9290 0.6940 0.1250]) % Z Limit
    xlabel("Sample Time (s)")
    legend(["X","Y","Z","X Limits","Y Limits","Z Limits"])
    hold off
end
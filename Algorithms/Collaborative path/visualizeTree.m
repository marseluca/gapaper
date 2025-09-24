function visualizeTree(tree)
    
    hold on;
    for i = 2:length(tree.nodes)
        plot([tree.nodes(i).parent.position(1), tree.nodes(i).position(1)], [tree.nodes(i).parent.position(2), tree.nodes(i).position(2)], 'Color','g');
    end
    for i = 1:length(tree.nodes)
        plot(tree.nodes(i).position(1), tree.nodes(i).position(2), 'bo');
    end
    hold on;


    axis equal;
    title('RRT* with Rewiring');
    drawnow;
end
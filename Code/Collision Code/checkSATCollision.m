function collision = checkSATCollision(hull1, hull2)
    % Check for collision between two convex hulls using SAT
    collision = false;
    
    % Get all unique edges for each convex hull
    edges1 = getEdges(hull1);
    edges2 = getEdges(hull2);
    
    % Calculate unique axes (normals) from each edge
    axes = [calculateNormals(edges1); calculateNormals(edges2)];
    
    % Perform SAT on all axes
    for i = 1:size(axes, 1)
        axis = axes(i, :);
        
        % Project both hulls onto the axis
        projection1 = projectOntoAxis(hull1, axis);
        projection2 = projectOntoAxis(hull2, axis);
        
        % Check for separation on this axis
        if projection1(2) < projection2(1) || projection2(2) < projection1(1)
            return;  % No collision if projections don't overlap
        end
    end
    
    % If no separating axis is found, collision is detected
    collision = true;
end
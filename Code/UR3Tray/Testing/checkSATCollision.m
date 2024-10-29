function collision = checkSATCollision(linkVertices, envVertices)
    % Perform SAT collision checking between two sets of vertices

    % Check collision for each pair (link and environment)
    collision = false;

    % Get edges for the link
    linkEdges = getEdges(linkVertices);
    % Get edges for the environment
    envEdges = getEdges(envVertices);
    
    % Combine edges for testing
    allEdges = {linkEdges, envEdges};
    
    % Check for each edge of both shapes
    for i = 1:length(allEdges)
        edges = allEdges{i};
        for j = 1:size(edges, 1)
            % Get the current edge
            edge = edges(j, :);
            % Get the normal vector of the edge
            normal = [linkVertices(edge(2), :) - linkVertices(edge(1), :)]; % Edge vector
            normal = [-normal(2), normal(1)];  % Perpendicular normal vector for 2D
            normal = normal / norm(normal);  % Normalize
            
            % Project both sets of vertices onto the normal
            [linkMin, linkMax] = projectVertices(linkVertices, normal);
            [envMin, envMax] = projectVertices(envVertices, normal);
            
            % Check for overlap in projections
            if linkMax < envMin || envMax < linkMin
                return;  % No collision on this axis
            end
        end
    end
    
    % If no separating axis is found, then there is a collision
    collision = true;
end

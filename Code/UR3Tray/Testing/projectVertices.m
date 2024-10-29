function [minProjection, maxProjection] = projectVertices(vertices, axis)
    % Project the vertices onto the given axis
    axis = axis(:)';  % Ensure the axis is a row vector
    projections = vertices * axis';  % Dot product for projection
    
    % Calculate the min and max projections
    minProjection = min(projections);
    maxProjection = max(projections);
end
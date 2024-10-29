function projection = projectOntoAxis(vertices, axis)
    % Project all vertices onto the given axis and return min/max of projections
    dots = vertices * axis';
    projection = [min(dots), max(dots)];
end
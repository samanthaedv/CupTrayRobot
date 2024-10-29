function edges = getEdges(vertices)
    % Create edges from vertex pairs in order, assumes vertices form a closed loop
    n = size(vertices, 1);
    edges = vertices([2:n, 1], :) - vertices;
end

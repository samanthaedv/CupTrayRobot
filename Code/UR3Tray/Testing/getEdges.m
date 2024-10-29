function edges = getEdges(vertices)
    % Get edges from a set of vertices
    numVertices = size(vertices, 1);
    edges = zeros(numVertices, 2);
    
    for i = 1:numVertices
        % Edge from vertex i to vertex i+1 (wrap around)
        edges(i, :) = [i, mod(i, numVertices) + 1]; 
    end
end
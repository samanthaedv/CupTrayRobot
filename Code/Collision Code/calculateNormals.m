function normals = calculateNormals(edges)
    % Calculate normals for each edge to use as axes for SAT
    normals = zeros(size(edges));
    for i = 1:size(edges, 1)
        edge = edges(i, :);
        normals(i, :) = [-edge(2), edge(1), 0];  % 2D normal assuming z = 0 for simplification
        % Normalize the normal vector
        normals(i, :) = normals(i, :) / norm(normals(i, :));
    end
end
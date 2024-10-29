function DrawBoundingBox(vertices, objectType, objectIndex)
    % Draw the edges of the bounding box defined by vertices
    edges = [
        1, 2; 2, 3; 3, 4; 4, 1; % Bottom face
        5, 6; 6, 7; 7, 8; 8, 5; % Top face
        1, 5; 2, 6; 3, 7; 4, 8; % Side edges
    ];
    
    for k = 1:size(edges, 1)
        plot3(vertices(edges(k, :), 1), vertices(edges(k, :), 2), vertices(edges(k, :), 3), ...
              'k-', 'LineWidth', 1.5);
    end
    
    % Display object identifier
    if nargin > 1
        text(mean(vertices(:, 1)), mean(vertices(:, 2)), mean(vertices(:, 3)), ...
             sprintf('%s %d', objectType, objectIndex), 'Color', 'r', 'FontSize', 10);
    end
end
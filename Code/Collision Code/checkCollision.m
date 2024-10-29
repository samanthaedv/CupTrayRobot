
function isCollision = checkCollision(linkVertices, envVertices)
    try
        % Use convhulln to generate convex hull indices
        linkHull = convhulln(linkVertices); 
        envHull = convhulln(envVertices);

        % Check if the convex hulls intersect (approximate method)
        isCollision = ~isempty(intersect(linkHull(:), envHull(:)));
    catch ME
        % In case of coplanar or collinear points, handle it here
        warning('Collision detection failed due to coplanar/collinear points. Using approximate method.');
        isCollision = pdist2(mean(linkVertices), mean(envVertices)) < 0.1; % Example threshold
    end
end
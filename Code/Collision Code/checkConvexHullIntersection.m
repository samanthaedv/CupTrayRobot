function collision = checkConvexHullIntersection(linkVerts, objectVerts)
    % Calculate convex hulls for both link and object vertices
    linkHullVerts = linkVerts(convhull(linkVerts), :);
    objectHullVerts = objectVerts(convhull(objectVerts), :);
    
    % Run the SAT collision check on these convex hull vertices
    collision = checkSATCollision(linkHullVerts, objectHullVerts);
end

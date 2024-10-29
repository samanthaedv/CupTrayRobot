function collisionDetected = checkCollision(robot, environment)
    collisionDetected = false;
    linkPoses = robot.model.fkine(robot.model.getpos());  % Get the poses of each link

    % Check each link for collision with environment objects
    for j = 1:length(linkPoses) - 1
        % Transform link vertices to world coordinates
        linkVerts = robot.model.links(j).vertices * linkPoses(j).T(1:3, 1:3)' + linkPoses(j).T(1:3, 4)';

        % Check collision with each environment object
        for k = 1:length(environment)
            if checkMeshIntersection(linkVerts, environment{k}.vertices)
                collisionDetected = true;
                return;
            end
        end
    end
end
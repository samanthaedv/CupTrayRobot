function collisionDetected = CheckCollisions(robot, q, environment)
    % Get link poses
    transforms = GetLinkPoses(q, robot);
    
    collisionDetected = false; % Initialize collision status
    
    % Define a thickness for each link (can be adjusted as needed)
    linkThickness = 0.1;
    
    % Loop through each link of the robot
    for i = 1:size(transforms, 3) - 1
        linkTransform = transforms(:, :, i); % Get the transformation of the i-th link
        
        % Get the DH parameters of the link
        L = robot.model.links(i);
        
        % Define the vertices of the link based on DH parameters
        linkLength = max(L.a, L.d); % Use the larger of a or d as link length
        linkVertices = [
            0, -linkThickness/2, -linkThickness/2;
            linkLength, -linkThickness/2, -linkThickness/2;
            linkLength, linkThickness/2, -linkThickness/2;
            0, linkThickness/2, -linkThickness/2;
            0, -linkThickness/2, linkThickness/2;
            linkLength, -linkThickness/2, linkThickness/2;
            linkLength, linkThickness/2, linkThickness/2;
            0, linkThickness/2, linkThickness/2;
        ];
        
        % Convert link vertices to homogeneous coordinates
        linkVertices = [linkVertices, ones(size(linkVertices, 1), 1)];
        transformedLinkVertices = (linkTransform * linkVertices')'; % Transform to world coordinates
        
        % Check for collisions with each environmental object
        for j = 1:length(environment)
            envVertices = environment(j).vertices; % Get vertices of the environmental object
            envTransform = environment(j).transform; % Get transform of the environmental object
            
            % Transform environmental vertices to world coordinates
            envVertices = [envVertices, ones(size(envVertices, 1), 1)]; % Homogeneous coordinates
            transformedEnvVertices = (envTransform * envVertices')';
            
            % Check for collision using the Convex Hull method
            if checkCollision(transformedLinkVertices(:, 1:3), transformedEnvVertices(:, 1:3))
                collisionDetected = true;
                fprintf('Collision detected between link %d and object %d.\n', i, j);
                return; % Exit if a collision is detected
            end
        end
    end
end
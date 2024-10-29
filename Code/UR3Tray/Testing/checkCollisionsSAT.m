function [collisions] = checkCollisionsSAT(robot, q, environmentObjects)
    % Get the transformation matrices for all links
    transforms = GetLinkPoses(q, robot);
    collisions = false(1, robot.model.n);  % Initialize collision flags

    hold on;  % Ensure we can plot for visualization

    % Iterate through each link of the robot
    for i = 1:robot.model.n
        % Get the transformation matrix for the current link
        linkTransform = transforms(:, :, i + 1);  % Get transformation for link i
        
        % Define the link geometry (assumed to be a straight line)
        linkLength = 0.1;  % Adjust this to the actual length of the link
        startPoint = linkTransform(1:3, 4);  % Origin of the link in world coordinates
        endPoint = startPoint + linkLength * linkTransform(1:3, 1);  % Direction along X-axis
        
        % Create vertices for the link (as a line segment)
        linkVertices = [startPoint'; endPoint'];
        
        % Check for collisions with the environment
        for j = 1:length(environmentObjects)
            envVertices = environmentObjects(j).vertices;  % Get the vertices of the environment object
            
            % Perform SAT collision checking
            if checkSATCollision(linkVertices, envVertices)
                collisions(i) = true;  % Mark collision
                % Optional: Visualize the collision (red link)
                plot3(linkVertices(:, 1), linkVertices(:, 2), linkVertices(:, 3), 'r-', 'LineWidth', 3);
            end
        end
    end
end
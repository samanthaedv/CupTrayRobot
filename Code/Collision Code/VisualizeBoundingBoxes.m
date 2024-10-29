function VisualizeBoundingBoxes(robot, q, environment)
    % Get link poses
    transforms = GetLinkPoses(q, robot);
    
    % Define a thickness for each link bounding box (adjust as needed)
    linkThickness = 0.1;
    
    hold on;
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    % Loop through each link of the robot
    for i = 1:size(transforms, 3) - 1
        linkTransform = transforms(:, :, i); % Get the transformation of the i-th link
        
        % Get the DH parameters of the link
        L = robot.model.links(i);
        
        % Define the vertices of the link bounding box based on DH parameters
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
        
        % Draw bounding box for the link
        DrawBoundingBox(transformedLinkVertices(:, 1:3), 'Link', i);
    end
    
    % Visualize environmental objects
    for j = 1:length(environment)
        envVertices = environment(j).vertices; % Get vertices of the environmental object
        % Uncomment the line below if environment vertices are already in world coordinates
        transformedEnvVertices = envVertices; 
        
        % If the vertices still require transformation, use this line:
        % transformedEnvVertices = (environment(j).transform * [envVertices, ones(size(envVertices, 1), 1)]')';
        
        % Draw bounding box for each environmental object
        DrawBoundingBox(transformedEnvVertices(:, 1:3), 'Environment', j);
        
        % Debug: Display mean position of vertices to verify placement
        fprintf('Environment %d position: (%.2f, %.2f, %.2f)\n', j, ...
            mean(transformedEnvVertices(:, 1)), mean(transformedEnvVertices(:, 2)), mean(transformedEnvVertices(:, 3)));
    end
    
    hold off;
end

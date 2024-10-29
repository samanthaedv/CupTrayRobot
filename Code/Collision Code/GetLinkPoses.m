function [transforms] = GetLinkPoses(q, robot)
    % Initialize transforms with base transform
    transforms = zeros(4, 4, length(q) + 1);
    transforms(:, :, 1) = robot.model.base;

    % Loop through each joint and apply the correct transformations
    for i = 1:length(q)
        L = robot.model.links(i); % Get link
        current_transform = transforms(:, :, i);

        if L.isrevolute
            % For revolute joints, rotate around the z-axis by q + offset
            joint_transform = trotz(q(i) + L.offset) * ...
                              transl(0, 0, L.d) * transl(L.a, 0, 0) * trotx(L.alpha);
        else
            % For prismatic joints, translate along z by q + d
            joint_transform = trotz(L.offset) * ...
                              transl(0, 0, q(i) + L.d) * transl(L.a, 0, 0) * trotx(L.alpha);
        end

        % Update the transformation for the current link
        transforms(:, :, i + 1) = current_transform * joint_transform;
    end
end
function [transforms] = GetLinkPoses(q, robot)
    transforms = zeros(4, 4, length(q) + 1);
    transforms(:, :, 1) = robot.model.base;

    for i = 1:length(q)
        L = robot.model.links(i);

        current_transform = transforms(:, :, i);

        current_transform = current_transform * trotz(q(1, i) + L.offset) * ...
            transl(0, 0, L.d) * transl(L.a, 0, 0) * trotx(L.alpha);
        transforms(:, :, i + 1) = current_transform;
    end
end

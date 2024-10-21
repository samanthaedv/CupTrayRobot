function [rposition,endEffectorPose] = moveRobotGrip(r,q0, q1, object)
qtraj = jtraj(q0, q1, 100);

for i = 1:size(qtraj, 1)
    r.model.animate(qtraj(i,:)); %animate all values in the matrix above
    rposition = r.model.getpos(); % get the current pos of the robot
    endEffectorPose = r.model.fkine(rposition).T; %check the solution with forward kinematics transpose it
    newVerts1 = (object.vertices(:,1:3) * endEffectorPose(1:3,1:3)') + endEffectorPose(1:3,4)';
    set(object.model, 'Vertices', newVerts1);
    drawnow();
end



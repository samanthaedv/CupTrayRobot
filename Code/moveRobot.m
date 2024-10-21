function [rposition,endEffectorPose] = moveRobot(r,q0, q1)
qtraj = jtraj(q0, q1, 100);

for i = 1:size(qtraj, 1)
    r.model.animate(qtraj(i,:)); %animate all values in the matrix above
    drawnow();
    rposition = r.model.getpos(); % get the current pos of the robot
    endEffectorPose = r.model.fkine(rposition).T; %check the solution with forward kinematics transpose it
end


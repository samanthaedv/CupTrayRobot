function [rposition,endEffectorPose] = moveRobotTray(r,q0, q1, object)
qtraj = jtraj(q0, q1, 100);

for i = 1:size(qtraj, 1)
    r.model.animate(qtraj(i,:)); %animate all values in the matrix above
    rposition = r.model.getpos(); % get the current pos of the robot
    endEffectorPose = r.model.fkine(rposition).T; %check the solution with forward kinematics transpose it
    object.TrayMove(endEffectorPose * troty(-pi/2)*trotz(-pi/2) *[1,0,0,0; ...
                                              0,1,0,0.25; ...
                                              0,0,1,0; ...
                                              0,0,0,1]);
    drawnow();
end



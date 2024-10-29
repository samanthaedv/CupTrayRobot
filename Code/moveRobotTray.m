function [rposition,endEffectorPose] = moveRobotTray(r,q0, q1, object)
qtraj = jtraj(q0, q1, 100);
global e_stop;

for i = 1:size(qtraj, 1)
    while e_stop
            pause(0.1);  % Pause briefly while e-stop is active
    end
    r.model.animate(qtraj(i,:)); %animate all values in the matrix above
    rposition = r.model.getpos(); % get the current pos of the robot
    endEffectorPose = r.model.fkine(rposition).T; %check the solution with forward kinematics transpose it
    
    if mod(i, 4) == 0
    object.TrayMove(endEffectorPose * troty(-pi/2)*trotz(-pi/2) *[1,0,0,0; ...
                                              0,1,0,0.25; ...
                                              0,0,1,0; ...
                                              0,0,0,1]);
    drawnow();
    end
    %{
    collisionDetected = CheckCollisions(r, qtraj(i,:),environment);
        if collisionDetected == true
            disp('Collision detected! Stopping movement.');
            VisualizeBoundingBoxes(r, qtraj(i,:), environment);
            
            pause()
            break;  % Stop if collision is detected
        end
    %}
end



function [rposition,endEffectorPose] = moveRobotCollisionTest(r,q0, q1, f1, v1, fn1)
global e_stop;
qtraj = jtraj(q0, q1, 100);

for i = 1:size(qtraj, 1)
    while e_stop
            pause(0.1);  % Pause briefly while e-stop is active
    end
    r.model.animate(qtraj(i,:)); %animate all values in the matrix above
    drawnow();
    rposition = r.model.getpos(); % get the current pos of the robot
    endEffectorPose = r.model.fkine(rposition).T; %check the solution with forward kinematics transpose it
    
    result1 = IsCollision(r,qtraj(i,:),f1,v1,fn1);
    
     if result1 == 1
        disp('Collision! ');
            e_stop = true;
        break
    end

end


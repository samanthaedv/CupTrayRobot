function [rposition, endEffectorPose] = moveRobotRMRC(r, q0, targetPose, timeSteps, deltaT)
    % Initialize variables
    q = q0;  % Start joint position
    rposition = zeros(timeSteps, numel(q0));  % Store joint positions
    endEffectorPose = zeros(4,4,timeSteps);  % Store end-effector poses

    for i = 1:timeSteps
        % Get the current end-effector pose
        Tr = r.model.fkine(q).T;
        
        % Error in pose (desired - current)
        deltaTrans = targetPose(1:3,4) - Tr(1:3,4)
        deltaRot = tr2rpy(targetPose(1:3,1:3)) - tr2rpy(Tr(1:3,1:3))
    
        deltaX = [deltaTrans; deltaRot']
        

        % Compute the Jacobian at the current joint position
        J = r.model.jacob0(q)
        
        % Use the pseudo-inverse of the Jacobian to compute joint velocity
        dq = pinv(J) * (deltaX / deltaT)
        
        % Update joint positions using Euler integration
        q = q + dq' * deltaT
        
        % Animate the robot
        r.model.animate(q);
        drawnow();

        % Store the current joint position and end-effector pose
        rposition(i, :) = q;
        endEffectorPose(:,:,i) = r.model.fkine(q).T;
    end
end
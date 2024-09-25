classdef AssignmentTesting < handle 

    methods
        function self = AssignmentTesting()
            self.Environment()
            self.Pickup()
            self.Joint()
            self.RUN()
        end 
    end 

    methods (Static)

        function Environment()
            hold on 
            h_1 = PlaceObject('fenceFinal.ply',[0.8,0,0]);
            verts = [get(h_1,'Vertices'), ones(size(get(h_1,'Vertices'),1),1)] * trotz(pi/2);
            verts(:,1) = verts(:,1)*4 ;
            set(h_1,'Vertices',verts(:,1:3))

            h_2 = PlaceObject('fenceFinal.ply',[-0.8,0,0]);
            verts = [get(h_2,'Vertices'), ones(size(get(h_2,'Vertices'),1),1)] * trotz(pi/2);
            verts(:,1) = verts(:,1)*4 ;
            set(h_2,'Vertices',verts(:,1:3))

            h_3 = PlaceObject('fenceFinal.ply',[0,0,0]);
            verts = [get(h_3,'Vertices'), ones(size(get(h_3,'Vertices'),1),1)];
            verts(:,2) = verts(:,2)*2 ;
            verts(:,1) = verts(:,1) + 1;
            set(h_3,'Vertices',verts(:,1:3))

            h_4 = PlaceObject('fenceFinal.ply',[0,0,0]);
            verts = [get(h_4,'Vertices'), ones(size(get(h_4,'Vertices'),1),1)];
            verts(:,2) = verts(:,2)*2;
            verts(:,1) = verts(:,1) - 1.5;
            set(h_4,'Vertices',verts(:,1:3))

            %simulate the environemnt 
            surf([-1.8,-1.8;1.8,1.8] ...
            ,[-1.8,1.8;-1.8,1.8] ...
            ,[0.01,0.01;0.01,0.01] ...
            ,'CData',imread('concrete.jpg') ...
            ,'FaceColor','texturemap');
        end 

        function Pickup()
        end 
        function Joint()
            clf;
            r = LinearUR3e();
            qlim = r.model.qlim;

            b1 = [0.5,0.25,0];
            current_POS = r.model.getpos()
            Inv_sol = r.model.ikine(transl(b1),current_POS)
            r.model.fkine(Inv_sol)
        end 
        function RUN()
            clc;
clf;
clear all;
hold on %without this hold on the assignemnt would look terrible 

%% SAFTEY!
%Look I'm not going to lie I just copied the code from lab 2 solutions, I
%had a different fence image but meshlab would crash 
h_1 = PlaceObject('fenceFinal.ply',[0.8,0,0]); %Here we are placing objects at x y z locations 
            verts = [get(h_1,'Vertices'), ones(size(get(h_1,'Vertices'),1),1)] * trotz(pi/2); % get the vertices rotate the fence 
            verts(:,1) = verts(:,1)*4 ; %make the fence longer 
            set(h_1,'Vertices',verts(:,1:3)) %set the vertices 

            h_2 = PlaceObject('fenceFinal.ply',[-0.8,0,0]); %exactly the same as above just a different pos 
            verts = [get(h_2,'Vertices'), ones(size(get(h_2,'Vertices'),1),1)] * trotz(pi/2);
            verts(:,1) = verts(:,1)*4 ;
            set(h_2,'Vertices',verts(:,1:3))

            h_3 = PlaceObject('fenceFinal.ply',[0,0,0]);
            verts = [get(h_3,'Vertices'), ones(size(get(h_3,'Vertices'),1),1)]; % no rotation for this one
            verts(:,2) = verts(:,2)*2 ; % fence isnt as big 
            verts(:,1) = verts(:,1) + 1; % the +1 is like an offest 
            set(h_3,'Vertices',verts(:,1:3))

            h_4 = PlaceObject('fenceFinal.ply',[0,0,0]);
            verts = [get(h_4,'Vertices'), ones(size(get(h_4,'Vertices'),1),1)];
            verts(:,2) = verts(:,2)*2;
            verts(:,1) = verts(:,1) - 1.5; % like the offset above but the opposite direction
            set(h_4,'Vertices',verts(:,1:3))

%simulate the environemnt 
% again more code I took from avail canvas areas 
surf([-1.8,-1.8;1.8,1.8] ...
,[-1.8,1.8;-1.8,1.8] ...
,[0.01,0.01;0.01,0.01] ...
,'CData',imread('concrete.jpg') ...
,'FaceColor','texturemap');
%% Brick position
% To start we place all the bricks 

brick1_POS = [-0.4, 0.4, 0]; %storage variable - -0.4 (x), 0.4 (y), 0 (z)
brick1 = PlaceObject('HalfSizedRedGreenBrick.ply',brick1_POS); %places the brick 
verts1 = [get(brick1,'Vertices'), ones(size(get(brick1,'Vertices'),1),1)]; 
%setting vertices for future transformations 
verts1(:,1) = verts1(:,1);

%From now on we are repeating what we did above, assiging a variable with
%an inital position, placing that object in the simulation, getting the
%vertices of the brick so we can transform them later 

brick2_POS = [-0.6, 0.4, 0]; 
brick2 = PlaceObject('HalfSizedRedGreenBrick.ply',brick2_POS);
verts2 = [get(brick2,'Vertices'), ones(size(get(brick2,'Vertices'),1),1)];
verts2(:,1) = verts2(:,1);

brick3_POS = [-0.8, 0.4, 0]; 
brick3 = PlaceObject('HalfSizedRedGreenBrick.ply',brick3_POS);
verts3 = [get(brick3,'Vertices'), ones(size(get(brick3,'Vertices'),1),1)];
verts3(:,1) = verts3(:,1);

brick4_POS = [-1.2, 0.2, 0]; 
brick4 = PlaceObject('HalfSizedRedGreenBrick.ply',brick4_POS);
verts4 = [get(brick4,'Vertices'), ones(size(get(brick4,'Vertices'),1),1)];
verts4(:,1) = verts4(:,1);

brick5_POS = [-1.2, 0, 0]; 
brick5 = PlaceObject('HalfSizedRedGreenBrick.ply',brick5_POS);
verts5 = [get(brick5,'Vertices'), ones(size(get(brick5,'Vertices'),1),1)];
verts5(:,1) = verts5(:,1);

brick6_POS = [-1.2, -0.2, 0]; 
brick6 = PlaceObject('HalfSizedRedGreenBrick.ply',brick6_POS);
verts6 = [get(brick6,'Vertices'), ones(size(get(brick6,'Vertices'),1),1)];
verts6(:,1) = verts6(:,1);

brick7_POS = [-0.8, 0.6, 0]; 
brick7 = PlaceObject('HalfSizedRedGreenBrick.ply',brick7_POS);
verts7 = [get(brick7,'Vertices'), ones(size(get(brick7,'Vertices'),1),1)];
verts7(:,1) = verts7(:,1);

brick8_POS = [-0.6, 0.6, 0]; 
brick8 = PlaceObject('HalfSizedRedGreenBrick.ply',brick8_POS);
verts8 = [get(brick8,'Vertices'), ones(size(get(brick8,'Vertices'),1),1)];
verts8(:,1) = verts8(:,1);
%its just a copy paste change variable names, thats it!
brick9_POS = [-0.4, 0.6, 0]; 
brick9 = PlaceObject('HalfSizedRedGreenBrick.ply',brick9_POS);
verts9 = [get(brick9,'Vertices'), ones(size(get(brick9,'Vertices'),1),1)];
verts9(:,1) = verts9(:,1);



%% Brick orientation 

%Brick 1
brick_1_ORI = eye(3); % Identity matrix for no rotation
brick_1_FINAL_ORI = eye(3);
brick1_final_POS = [0.4,0,0.037];
% Create a 4x4 transformation matrix for the brick's initial pose
% Apply a 180-degree rotation around the X-axis to flip the orientation
% for end's effector pointing downward
flipMatrix = [1, 0, 0, 0;
             0, -1, 0, 0;
             0, 0, -1, 0;
             0, 0, 0, 1];
brick1_POS = [brick_1_ORI, [-0.4, 0.4, 0.0366155]'; 0, 0, 0, 1]; %The last row for homogeneous coordinates
brick1_final_POS = [brick_1_FINAL_ORI, brick1_final_POS'; 0, 0, 0, 1]; 
% Apply the rotation to the original 'brick1_POS'
brick1_POS = brick1_POS * flipMatrix;
brick1_final_POS = brick1_final_POS * flipMatrix;

%Brick 2
brick_2_ORI = eye(3); % Identity matrix for no rotation
brick_2_FINAL_ORI = eye(3);
brick2_final_POS = [0.4,0,0.073];
% Create a 4x4 transformation matrix for the brick's initial pose
% Apply a 180-degree rotation around the X-axis to flip the orientation
% for end's effector pointing downward
flipMatrix = [1, 0, 0, 0; %this flip matrix is the same as the one above
             0, -1, 0, 0; %from now on it will not be included in the setup
             0, 0, -1, 0; %sinc the value doesn't change 
             0, 0, 0, 1];
brick2_POS = [brick_2_ORI, [-0.6, 0.4, 0.0366155]'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
brick2_final_POS = [brick_2_FINAL_ORI, brick2_final_POS'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
% Apply the rotation to the original 'brick2_POS'
brick2_POS = brick2_POS * flipMatrix;
brick2_final_POS = brick2_final_POS * flipMatrix;

%Brick 3
brick_3_ORI = eye(3); % Identity matrix for no rotation
brick_3_FINAL_ORI = eye(3);
brick3_final_POS = [0.4,0,0.109];
brick3_POS = [brick_3_ORI, [-0.8, 0.4, 0.0366155]'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
brick3_final_POS = [brick_3_FINAL_ORI, brick3_final_POS'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
% Apply the rotation to the original 'brick3_POS'
brick3_POS = brick3_POS * flipMatrix;
brick3_final_POS = brick3_final_POS * flipMatrix;

%Brick 4
brick_4_ORI = eye(3); % Identity matrix for no rotation
brick_4_FINAL_ORI = eye(3);
brick4_final_POS = [0.4,0.15,0.037];
brick4_POS = [brick_4_ORI, [-1.2, 0.2, 0.0366155]'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
brick4_final_POS = [brick_4_FINAL_ORI, brick4_final_POS'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
% Apply the rotation to the original 'brick4_POS'
brick4_POS = brick4_POS * flipMatrix;
brick4_final_POS = brick4_final_POS * flipMatrix;

%Brick 5
brick_5_ORI = eye(3); % Identity matrix for no rotation
brick_5_FINAL_ORI = eye(3);
brick5_final_POS = [0.4,0.15,0.073];
brick5_POS = [brick_5_ORI, [-1.2, 0, 0.0366155]'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
brick5_final_POS = [brick_5_FINAL_ORI, brick5_final_POS'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
% Apply the rotation to the original 'brick5_POS'
brick5_POS = brick5_POS * flipMatrix;
brick5_final_POS = brick5_final_POS * flipMatrix;

%Brick 6
brick_6_ORI = eye(3); % Identity matrix for no rotation
brick_6_FINAL_ORI = eye(3);
brick6_final_POS = [0.4,0.15,0.109];
brick6_POS = [brick_6_ORI, [-1.2, -0.2, 0.0366155]'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
brick6_final_POS = [brick_6_FINAL_ORI, brick6_final_POS'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
% Apply the rotation to the original 'brick6_POS'
brick6_POS = brick6_POS * flipMatrix;
brick6_final_POS = brick6_final_POS * flipMatrix;

%Brick 7
brick_7_ORI = eye(3); % Identity matrix for no rotation
brick_7_FINAL_ORI = eye(3);
brick7_final_POS = [0.4,0.3,0.037];
brick7_POS = [brick_7_ORI, [-0.8, 0.6, 0.0366155]'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
brick7_final_POS = [brick_7_FINAL_ORI, brick7_final_POS'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
% Apply the rotation to the original 'brick7_POS'
brick7_POS = brick7_POS * flipMatrix;
brick7_final_POS = brick7_final_POS * flipMatrix;

%Brick 8
brick_8_ORI = eye(3); % Identity matrix for no rotation
brick_8_FINAL_ORI = eye(3);
brick8_final_POS = [0.4,0.3,0.073];
brick8_POS = [brick_8_ORI, [-0.6, 0.6, 0.0366155]'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
brick8_final_POS = [brick_8_FINAL_ORI, brick8_final_POS'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
% Apply the rotation to the original 'brick6_POS'
brick8_POS = brick8_POS * flipMatrix;
brick8_final_POS = brick8_final_POS * flipMatrix;

%Brick 9
brick_9_ORI = eye(3); % Identity matrix for no rotation
brick_9_FINAL_ORI = eye(3);
brick9_final_POS = [0.4, 0.3, 0.109];
brick9_POS = [brick_9_ORI, [-0.4, 0.6, 0.0366155]'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
brick9_final_POS = [brick_9_FINAL_ORI, brick9_final_POS'; 0, 0, 0, 1]; % The last row for homogeneous coordinates
% Apply the rotation to the original 'brick6_POS'
brick9_POS = brick9_POS * flipMatrix;
brick9_final_POS = brick9_final_POS * flipMatrix;

%% MOVEMENT finally... 

%brick 1
q0 = zeros(1,7); %starting home position or 0 vector 
steps = 100; 
r = LinearUR3e; %load the model 
pause(5)

% Move the robot arm from q0 to q1
q1 = r.model.ikcon(brick1_POS); %ikcon incorporates joint limits so we can find a solution for the joint angles to get to the first brick 
qtraj1 = jtraj(q0, q1, steps); %this creates a 2x100 matrix that will be used to animate the joint angles

% Display q1
% just extra stuff for joint angles so i can test them later 
disp('q1:');
disp(q1);

% Animate the robot arm from q0 to q1
for i = 1:size(qtraj1, 1)
    r.model.animate(qtraj1(i,:)); %animate all values in the matrix above  
    drawnow();
    pause(0); % probably dont need this but it was good for testing and seeing where things went
    % Update the end effector pose
    rposition = r.model.getpos(); % get the current pos of the robot
    endEffectorPose = r.model.fkine(rposition).T; %check the solution with forward kinematics transpose it
end

% Calculate the transformation matrix that maps the initial brick position to the end effector position
brickTransform = endEffectorPose * inv(brick1_POS);  % Calculate the transform
% Set brick1 based on the end effector pose at the end 
newVerts1 = (verts1(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick1, 'Vertices', newVerts1);
%above is just some calculations to work out the vertices for the brick 
% Move the robot arm from q1 to q2
q2 = r.model.ikcon(brick1_final_POS); %using ikcon to get the joint angles of the final pos 
qtraj2 = jtraj(q1, q2, steps); % traj to find the joint angles betweent the two points 
% Display q2
%more displays 
disp('q2:');
disp(q2);
% Animate the robot arm from q1 to q2
%basically I'm going from the inital pos of the brick to the end pos of the
%brick, then saving that to a new matrix and animating that 
for i = 1:size(qtraj2, 1)
    r.model.animate(qtraj2(i,:));
    rposition = r.model.getpos(); %update the current pos of the robot joints
    endEffectorPose = r.model.fkine(rposition).T; %check my solution and transpose 
    % Calculate the transformation matrix that maps the initial brick position to the end effector position
    brickTransform = endEffectorPose * inv(brick1_POS);  % Calculate the transformation
    newVerts1 = (verts1(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick1, 'Vertices', newVerts1);
    %more calcuations for the end vertex of the brick 
    drawnow();
    pause(0); %dont need this but good for testing if something is off in the loop
end
%% brick 2

%from end position to next brick 
%from now on the code is a repeat of itself, i store all the values for
%later testing

% Move the robot arm from q2 to q3
q3 = r.model.ikcon(brick2_POS);
qtraj3 = jtraj(q2, q3, steps);
% Display q2
disp('q3:');
disp(q3);

for i = 1:size(qtraj3, 1)
    r.model.animate(qtraj3(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    drawnow();
    pause(0);
end

%from brick to end pos 

% Calculate the transformation matrix that maps the initial brick position to the end effector position
brickTransform = endEffectorPose * inv(brick2_POS);  % Calculate the transformation
newVerts2 = (verts2(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick2, 'Vertices', newVerts2);
q4 = r.model.ikcon(brick2_final_POS);
qtraj4 = jtraj(q3, q4, steps);
disp('q4:');
disp(q4);
%animate 
for i = 1:size(qtraj4, 1)
    r.model.animate(qtraj4(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    % Calculate the transformation matrix that maps the initial brick position to the end effector position
    brickTransform = endEffectorPose * inv(brick2_POS);  
    newVerts2 = (verts2(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick2, 'Vertices', newVerts2);
    drawnow();
    pause(0);
end

%% brick 3
%from end pos to brick 

q5 = r.model.ikcon(brick3_POS);
qtraj5 = jtraj(q4, q5, steps);

disp('q5:');
disp(q5);

for i = 1:size(qtraj5, 1)
    r.model.animate(qtraj5(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    drawnow();
    pause(0);
end

%%from brick to end pos 

brickTransform = endEffectorPose * inv(brick3_POS);  % Calculate the transformation

newVerts3 = (verts3(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick3, 'Vertices', newVerts3);

%move
q6 = r.model.ikcon(brick3_final_POS);
qtraj6 = jtraj(q5, q6, steps);
% Display q2
disp('q6:');
disp(q6);

% Animate 
for i = 1:size(qtraj6, 1)
    r.model.animate(qtraj6(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    % Calculate the transformation matrix that maps the initial brick position to the end effector position
    brickTransform = endEffectorPose * inv(brick3_POS);  % Calculate the transformation
    newVerts3 = (verts3(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick3, 'Vertices', newVerts3);
    drawnow();
    pause(0);
end

%% brick 4 


q7 = r.model.ikcon(brick4_POS);
qtraj7 = jtraj(q6, q7, steps);

disp('q7:');
disp(q7);

% Animate 
for i = 1:size(qtraj7, 1)
    r.model.animate(qtraj7(i,:));
    drawnow();
    pause(0);
    % Update pos 
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
end


brickTransform = endEffectorPose * inv(brick4_POS);  % Calculate the transformation

newVerts4 = (verts4(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick4, 'Vertices', newVerts4);
% Move the arm 
q8 = r.model.ikcon(brick4_final_POS);
qtraj8 = jtraj(q7, q8, steps);

disp('q8:');
disp(q8);
% Animate the robot arm from q1 to q2
for i = 1:size(qtraj8, 1)
    r.model.animate(qtraj8(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    % Calculate the transformation matrix that maps the initial brick position to the end effector position
    brickTransform = endEffectorPose * inv(brick4_POS);  % Calculate the transformation
    newVerts4 = (verts4(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick4, 'Vertices', newVerts4);
    drawnow();
    pause(0);
end

%% brick 5 


q9 = r.model.ikcon(brick5_POS);
qtraj9 = jtraj(q8, q9, steps);


disp('q9:');
disp(q9);

% Animate
for i = 1:size(qtraj9, 1)
    r.model.animate(qtraj9(i,:));
    drawnow();
    pause(0);
    % Update 
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
end


brickTransform = endEffectorPose * inv(brick5_POS);  % Calculate the transformation
newVerts5 = (verts5(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick5, 'Vertices', newVerts5);
q10 = r.model.ikcon(brick5_final_POS);
qtraj10 = jtraj(q9, q10, steps);

disp('q10:');
disp(q10);
% Animate 
for i = 1:size(qtraj10, 1)
    r.model.animate(qtraj10(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    % Calculate the transformation matrix that maps the initial brick position to the end effector position
    brickTransform = endEffectorPose * inv(brick5_POS);  % Calculate the transformation
    newVerts5 = (verts5(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick5, 'Vertices', newVerts5);
    drawnow();
    pause(0);
end
%% brick 6 


q11 = r.model.ikcon(brick6_POS);
qtraj11 = jtraj(q10, q11, steps);


disp('q11:');
disp(q11);

% Animate 
for i = 1:size(qtraj11, 1)
    r.model.animate(qtraj11(i,:));
    drawnow();
    pause(0);
    % Update 
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
end


% Calculate the transformation matrix that maps the initial brick position to the end effector position
brickTransform = endEffectorPose * inv(brick6_POS);  % Calculate the transformation
newVerts6 = (verts6(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick6, 'Vertices', newVerts6);
% Move the robot arm from q1 to q2
q12 = r.model.ikcon(brick6_final_POS);
qtraj12 = jtraj(q11, q12, steps);
% Display q12
disp('q12:');
disp(q12);
% Animate 
for i = 1:size(qtraj12, 1)
    r.model.animate(qtraj12(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    % Calculate the transformation matrix that maps the initial brick position to the end effector position
    brickTransform = endEffectorPose * inv(brick6_POS);  % Calculate the transformation
    newVerts6 = (verts6(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick6, 'Vertices', newVerts6);
    drawnow();
    pause(0);
end
 %% brick 7 

%from end position to next brick 

q13 = r.model.ikcon(brick7_POS);
qtraj13 = jtraj(q12, q13, steps);

disp('q13:');
disp(q13);

for i = 1:size(qtraj13, 1)
    r.model.animate(qtraj13(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    drawnow();
    pause(0);
end

%from brick to end pos 

% Calculate the transformation matrix that maps the initial brick position to the end effector position
brickTransform = endEffectorPose * inv(brick7_POS);  % Calculate the transformation

newVerts7 = (verts7(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick7, 'Vertices', newVerts7);
% Move 
q14 = r.model.ikcon(brick7_final_POS);
qtraj14 = jtraj(q13, q14, steps);
% Display 
disp('q4:');
disp(q14);
% Animate 
for i = 1:size(qtraj14, 1)
    r.model.animate(qtraj14(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    % Calculate the transformation matrix that maps the initial brick position to the end effector position
    brickTransform = endEffectorPose * inv(brick7_POS);  % Calculate the transformation
    newVerts7 = (verts7(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick7, 'Vertices', newVerts7);
    drawnow();
    pause(0);
end

%% brick 8 

%from end position to next brick 

% Move the robot arm from q7 to q3
q15 = r.model.ikcon(brick8_POS);
qtraj15 = jtraj(q14, q15, steps);
% Display q2
disp('q15:');
disp(q15);

for i = 1:size(qtraj15, 1)
    r.model.animate(qtraj15(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    drawnow();
    pause(0);
end

%from brick to end pos 


brickTransform = endEffectorPose * inv(brick8_POS);  % Calculate the transformation

newVerts8 = (verts8(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick8, 'Vertices', newVerts8);

q16 = r.model.ikcon(brick8_final_POS);
qtraj16 = jtraj(q15, q16, steps);

disp('q16:');
disp(q16);
% Animate 
for i = 1:size(qtraj16, 1)
    r.model.animate(qtraj16(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    
    brickTransform = endEffectorPose * inv(brick8_POS);  % Calculate the transformation
    newVerts8 = (verts8(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick8, 'Vertices', newVerts8);
    drawnow();
    pause(0);
end

%% brick 9 

%from end position to next brick 


q17 = r.model.ikcon(brick9_POS);
qtraj17 = jtraj(q16, q17, steps);

disp('q17:');
disp(q17);

for i = 1:size(qtraj17, 1)
    r.model.animate(qtraj17(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    drawnow();
    pause(0);
end

%from brick to end pos 


brickTransform = endEffectorPose * inv(brick9_POS);  % Calculate the transformation

newVerts9 = (verts9(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
set(brick9, 'Vertices', newVerts9);
% Move 
q18 = r.model.ikcon(brick9_final_POS);
qtraj18 = jtraj(q17, q18, steps);

disp('q18:');
disp(q18);

for i = 1:size(qtraj18, 1)
    r.model.animate(qtraj18(i,:));
    rposition = r.model.getpos();
    endEffectorPose = r.model.fkine(rposition).T;
    % Calculate the transformation matrix 
    brickTransform = endEffectorPose * inv(brick9_POS);  
    newVerts9 = (verts9(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brick9, 'Vertices', newVerts9);
    drawnow();
    pause(0);
end
        end 
    end 
end 
            

       
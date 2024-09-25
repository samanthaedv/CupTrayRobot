classdef Assignment1 < handle 

    methods
        function self = Assignment1()
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


posArray = [
   -0.4000,    0.4000,         0;
   -0.6000,    0.4000,         0;
   -0.8000,    0.4000,         0;
   -1.2000,    0.4000,         0;
   -1.2000,         0.2,         0;
   -1.2000,    0,         0;
   -0.8000,    0.6000,         0;
   -0.6000,    0.6000,         0;
   -0.4000,    0.6000,         0
];

endPosArray = [
    0.4, 0.3, 0.037;
    0.4, 0.3, 0.073;
    0.4, 0.3, 0.109;
    0.4, 0.15, 0.037;
    0.4, 0.15, 0.073;
    0.4, 0.15, 0.109;
    0.4, 0, 0.037;
    0.4, 0, 0.073;
    0.4, 0, 0.109
    ]


for i = 1:9
    brickArray(i) = Bricked(posArray(i,:), endPosArray(i,:));
end

brickArray(1).destinationPOS

%% MOVEMENT finally... 

%brick 1
%q0 = zeros(1,7); %starting home position or 0 vector 
q0 = [ -0.01   0    0.5304    1.5916    5.2320   -1.5707    0.0007];
steps = 100; 
r = LinearUR3e; %load the model 

r.model.qlim

% Move the robot arm from q0 to q1


for k = 1:9

    q1 = r.model.ikcon(brickArray(k).POS, q0); %ikcon incorporates joint limits so we can find a solution for the joint angles to get to the first brick
    qtraj = jtraj(q0, q1, steps); %this creates a 2x100 matrix that will be used to animate the joint angles

    % Display q1
    % just extra stuff for joint angles so i can test them later
    disp('q1:');
    disp(q1);

    % Animate the robot arm from q0 to q1
    for i = 1:size(qtraj, 1)
        r.model.animate(qtraj(i,:)); %animate all values in the matrix above
        drawnow();
        %pause(0); % probably dont need this but it was good for testing and seeing where things went
        % Update the end effector pose
        rposition = r.model.getpos(); % get the current pos of the robot
        endEffectorPose = r.model.fkine(rposition).T; %check the solution with forward kinematics transpose it
    end

    

    % Calculate the transformation matrix that maps the initial brick position to the end effector position
    brickTransform = endEffectorPose * inv(brickArray(k).POS);  % Calculate the transform
    % Set brick1 based on the end effector pose at the end
    newVerts1 = (brickArray(k).verts(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
    set(brickArray(k).model, 'Vertices', newVerts1);
    %above is just some calculations to work out the vertices for the brick
    % Move the robot arm from q1 to q2
    q2 = r.model.ikcon(brickArray(k).destinationPOS); %using ikcon to get the joint angles of the final pos
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
        brickTransform = endEffectorPose * inv(brickArray(k).POS);  % Calculate the transformation
        newVerts1 = (brickArray(k).verts(:,1:3) * brickTransform(1:3,1:3)') + brickTransform(1:3,4)';
        set(brickArray(k).model, 'Vertices', newVerts1);
        %more calcuations for the end vertex of the brick
        drawnow();
        pause(0); %dont need this but good for testing if something is off in the loop
    end


    qtrajRet = jtraj(q2, q0, steps); % traj to find the joint angles betweent the two points
    % Display q2
    %more displays
    disp('qRet:');
    disp(q0);
    % Animate the robot arm from q1 to q2
    %basically I'm going from the inital pos of the brick to the end pos of the
    %brick, then saving that to a new matrix and animating that
    for i = 1:size(qtrajRet, 1)
        r.model.animate(qtrajRet(i,:));
        rposition = r.model.getpos(); %update the current pos of the robot joints
        endEffectorPose = r.model.fkine(rposition).T; %check my solution and transpose
      
        pause(0); %dont need this but good for testing if something is off in the loop
    end
    
    


end

end 
            

    end
end
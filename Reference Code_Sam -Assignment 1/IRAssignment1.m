classdef IRAssignment1 < handle 

    properties
        r;
        fingerLeft;
        fingerRight;
        L = log4matlab('IRAssignment1.log');
        

    end

    methods
        function self = IRAssignment1()
            cla;
            self.r = LinearUR3e;
            self.fingerLeft = GripperFingerLeft;
            self.fingerRight = GripperFingerRight;
            self.Testing();
            self.Workspace();
            %self.FingerAndArm();
           

            
        end
    end

    methods
        
        function Testing(self)
            hold on;

            %Set Axis

            axis([-2 1 -1.7 2.5 -1.2 1])

            %Set Variables

            waypoint = [-0.1913,   -1.6800,    0.0137,    1.0865,    0.4706,   -1.5708,    0];
            fingerRotation = troty(pi/2)*trotx(pi/2)*trotz(pi/2); %so gripper is correctly mounted to robot
         


            %% Set Brick Transforms and Robot Base 

            brick1Transform = trotx(pi/2)*troty(pi/2)*transl(0.4,0,0)*trotx(-pi/2);
            brick2Transform= brick1Transform*transl(0,0.2,0);
            brick3Transform= brick1Transform*transl(0,0.4,0);
            brick4Transform= brick1Transform*transl(0,0.6,0);
            brick5Transform= brick1Transform*transl(0,0.8,0);
            brick6Transform= brick1Transform*transl(0.10,0.1,0);
            brick7Transform= brick1Transform*transl(0.15,0.3,0);
            brick8Transform= brick1Transform*transl(0.15,0.5,0);
            brick9Transform= brick1Transform*transl(0.15,0.7,0);

            self.r.model.base = brick1Transform*transl(-0.4,0,0)*trotx(pi/2);
            %% Place Floor and Wall
            surf([-2, -2; 1, 1], ...
            [-1.7, 2.5; -1.7, 2.5], ...
            [-1.2, -1.2; -1.2, -1.2], ...
            'CData', imread('concrete.jpg'), ...
            'FaceColor', 'texturemap');

            surf([-2, -2; 1, 1], ...
            [-1.7, -1.7; -1.7, -1.7], ...
            [-1.2, 1; -1.2, 1], ...
            'CData', imread('concrete.jpg'), ...
            'FaceColor', 'texturemap');


            %% Place Table

            table = PlaceObject('table.ply');
            tableVertices = get(table, 'Vertices');
            maxZTable = max(tableVertices(:, 3));
            tableVertices(:, 3) = (tableVertices(:, 3) - maxZTable);
            %Table plotted in relation to robot
            transformedVertices = [tableVertices,ones(size(tableVertices,1),1)] * (self.r.model.base.T*transl(0,0,-0.4)*trotx(-pi/2))';
            set(table,'Vertices',transformedVertices(:,1:3));

            %% Place E-Stop

            estop = PlaceObject('estop.ply');
            estopVerts = get(estop, 'Vertices');
            %E-stop plotted in relation to robot
            transformedVerticesE = [estopVerts,ones(size(estopVerts,1),1)] * (self.r.model.base.T*transl(1.3,0,-0.4)*troty(-pi/2))';
            set(estop,'Vertices',transformedVerticesE(:,1:3));

            %% Place Mesh

            mesh = PlaceObject('mesh.PLY');
            meshVerts = get(mesh, 'Vertices');
            zCoordinates = meshVerts(:, 1);  
            meshHeight = max(zCoordinates) - min(zCoordinates);        
            %Mesh plotted in relation to robot
            transformedVerticesM = [meshVerts,ones(size(meshVerts,1),1)] * (self.r.model.base.T*transl(1,0.5*meshHeight,-0.4)*troty(-pi/2)*trotz(pi/2))';
            set(mesh,'Vertices',transformedVerticesM(:,1:3));
            

            %% Place Bricks

            [brick1, brick1Base, brick1Vertices] = self.PlaceBrick(brick1Transform);  
            [brick2, brick2Base, brick2Vertices] = self.PlaceBrick(brick2Transform);
            [brick3, brick3Base, brick3Vertices] = self.PlaceBrick(brick3Transform);
            [brick4, brick4Base, brick4Vertices] = self.PlaceBrick(brick4Transform);
            [brick5, brick5Base, brick5Vertices] = self.PlaceBrick(brick5Transform);
            [brick6, brick6Base, brick6Vertices] = self.PlaceBrick(brick6Transform);
            [brick7, brick7Base, brick7Vertices] = self.PlaceBrick(brick7Transform);
            [brick8, brick8Base, brick8Vertices] = self.PlaceBrick(brick8Transform);
            [brick9, brick9Base, brick9Vertices] = self.PlaceBrick(brick9Transform);

            %Brick Dropoff Locations
            %Brick Collection Order is (6,7,8,9,1,2,3,4,5)


            startBrickDropCoord = [-0.5, -0.5, 0.1];
            brickHeight = 0.0334;
            brickLength = 0.133;
            brick7Coord = [-0.5, -0.5, 0.1+brickHeight];
            brick8Coord = [-0.5, -0.5, 0.1+2*brickHeight];
            brick9Coord = [-0.5+brickLength, -0.5, 0.1];
            brick1Coord = [-0.5+brickLength, -0.5, 0.1+brickHeight];
            brick2Coord = [-0.5+brickLength, -0.5, 0.1+2*brickHeight];
            brick3Coord = [-0.5+2*brickLength, -0.5, 0.1];
            brick4Coord = [-0.5+2*brickLength, -0.5, 0.1+brickHeight];
            brick5Coord = [-0.5+2*brickLength, -0.5, 0.1+2*brickHeight];

            

            
            %Plot robot so it is near the bricks
            
           
            
            self.r.model.animate(self.r.model.getpos);
            self.fingerLeft.model.base = self.r.model.fkine(self.r.model.getpos).T*fingerRotation;
            self.fingerRight.model.base = self.r.model.fkine(self.r.model.getpos).T*fingerRotation;
            
            input('Ready to Build?')

            %% START BUILDING
            %Pick up brick 6 

            self.OpenGripper
            initialGuess = [-0.0100,   -0.2369,    0.0059,   -0.0217,    0,   -1.6517,   -0.3819];
            self.MoveToBrick(brick6Base, initialGuess);
            previousBrick = self.r.model.getpos;
            initialGuessRow2 = self.r.model.getpos();
            self.CloseGripper

            %Drop off brick 6

            self.GoToWaypoint(waypoint, brick6, brick6Vertices)
            initialGuess = [-0.5551,    -3.1271,    1.1309,    0.7497,   -0.3770,   -1.6517,   0]; 
            self.GoToDropBrick(startBrickDropCoord, initialGuess, brick6Vertices, brick6);
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper
            
            %Pick up brick 7 
          
            self.GoToWaypoint(waypoint)
            self.MoveToBrick(brick7Base, previousBrick);
            previousBrick = self.r.model.getpos;
            self.CloseGripper

            %Drop off brick 7

            self.GoToWaypoint(waypoint, brick7, brick7Vertices)
            self.GoToDropBrick(brick7Coord, previousBrickPlace, brick7Vertices, brick7);
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper
          
            %Pick up brick 8 

            self.GoToWaypoint(waypoint)
            self.MoveToBrick(brick8Base, previousBrick);
            previousBrick = self.r.model.getpos;
            self.CloseGripper

            %Drop off brick 8

            self.GoToWaypoint(waypoint, brick8, brick8Vertices)
            self.GoToDropBrick(brick8Coord, previousBrickPlace, brick8Vertices, brick8);
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper

            %Pick up brick 9

            self.GoToWaypoint(waypoint)
            self.MoveToBrick(brick9Base, previousBrick);
            previousBrick = self.r.model.getpos;
            self.CloseGripper
            
            %Drop off brick 9

            self.GoToWaypoint(waypoint, brick9, brick9Vertices)
            self.GoToDropBrick(brick9Coord, previousBrickPlace, brick9Vertices, brick9);
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper

            %Pick up brick 1

            self.GoToWaypoint(waypoint)
            self.MoveToBrick(brick1Base, initialGuessRow2);
            previousBrick = self.r.model.getpos;
            self.CloseGripper
            
            %Drop off brick 1

            self.GoToWaypoint(waypoint, brick1, brick1Vertices)
            self.GoToDropBrick(brick1Coord, previousBrickPlace, brick1Vertices, brick1);
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper

            %Pick up brick 2
            
            self.GoToWaypoint(waypoint)
            self.MoveToBrick(brick2Base, previousBrick);
            previousBrick = self.r.model.getpos;
            self.CloseGripper

            %Drop off brick 2
            self.GoToWaypoint(waypoint, brick2, brick2Vertices)
            self.GoToDropBrick(brick2Coord, previousBrickPlace, brick2Vertices, brick2)
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper
            
            %Pick up brick 3
            self.GoToWaypoint(waypoint)
            self.MoveToBrick(brick3Base, previousBrick)
            previousBrick = self.r.model.getpos;
            self.CloseGripper
            
            %Drop off brick 3
            self.GoToWaypoint(waypoint, brick3, brick3Vertices)
            self.GoToDropBrick(brick3Coord, previousBrickPlace, brick3Vertices, brick3)
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper
            
            %Pick up brick 4 
            self.GoToWaypoint(waypoint)
            self.MoveToBrick(brick4Base, previousBrick)
            previousBrick = self.r.model.getpos;
            self.CloseGripper

            %Drop off brick 4
            
            self.GoToWaypoint(waypoint, brick4, brick4Vertices)
            self.GoToDropBrick(brick4Coord, previousBrickPlace, brick4Vertices, brick4)
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper

            %Pick up brick 5
            self.GoToWaypoint(waypoint)
            self.MoveToBrick(brick5Base, previousBrick)
            previousBrick = self.r.model.getpos;
            self.CloseGripper

            %Drop off brick 5
            self.GoToWaypoint(waypoint, brick5, brick5Vertices)
            self.GoToDropBrick(brick5Coord, previousBrickPlace, brick5Vertices, brick5)
            previousBrickPlace = self.r.model.getpos;
            self.OpenGripper

            self.GoToWaypoint(waypoint)

            self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),'Building is complete'}; 
            disp('Building is complete')

            end

        

            
        function Workspace(self)


                hold on;
                
                %Joints I'm looking at for processing reasons 

                joint1Qlim = [-0.8 -0.01];
                joint2Qlim = [-180 180]*pi/180;
                joint3Qlim = [-90 90]*pi/180;
                joint4Qlim = [-170 170]*pi/180;
                joint5Qlim = [-180 180]*pi/180;
                joint6Qlim = [-180 180]*pi/180;
                % Note: Joint 7 is not included
                
                % Sampling steps
                stepJoint1 = 0.1; 
                stepOtherJoints = 45*pi/180;
                
               
                numJoint1Points = floor((joint1Qlim(2) - joint1Qlim(1)) / stepJoint1) + 1;
                numJoint2Points = floor((joint2Qlim(2) - joint2Qlim(1)) / stepOtherJoints) + 1;
                numJoint3Points = floor((joint3Qlim(2) - joint3Qlim(1)) / stepOtherJoints) + 1;
                numJoint4Points = floor((joint4Qlim(2) - joint4Qlim(1)) / stepOtherJoints) + 1;
                numJoint5Points = floor((joint5Qlim(2) - joint5Qlim(1)) / stepOtherJoints) + 1;
                numJoint6Points = floor((joint6Qlim(2) - joint6Qlim(1)) / stepOtherJoints) + 1;
                
        
                totalPointCloudSize = prod([numJoint1Points, numJoint2Points, numJoint3Points, numJoint4Points, numJoint5Points, numJoint6Points]);
                pointCloud = zeros(totalPointCloudSize,3);
                
                counter = 1;
                
                axis([-2 1 -1 1 -1 1]);

                tic
             

                for q1 = joint1Qlim(1):stepJoint1:joint1Qlim(2)
                    for q2 = joint2Qlim(1):stepOtherJoints:joint2Qlim(2)
                        for q3 = joint3Qlim(1):stepOtherJoints:joint3Qlim(2)
                            for q4 = joint4Qlim(1):stepOtherJoints:joint4Qlim(2)
                                for q5 = joint5Qlim(1):stepOtherJoints:joint5Qlim(2)
                                    for q6 = joint6Qlim(1):stepOtherJoints:joint6Qlim(2)
                                       
                                            q7 = 0;
                                            q = [q1,q2,q3,q4,q5,q6,q7];
                    
                                            trFKineMethod2 = self.r.model.fkineUTS(q);
                    
                                            tr = trFKineMethod2;

                                            if tr(3,4) >= 0
                                            % Add the point to the point cloud if z >= 0
                                            pointCloud(counter,:) = tr(1:3,4)';
                                            counter = counter + 1; 
                                            end


                                            if mod(counter/totalPointCloudSize * 100,1) == 0
                                                disp(['After ',num2str(toc),' seconds, completed ',num2str(counter/totalPointCloudSize * 100),'% of poses']);
                                            end
                                       
                                     end
                                end
                            end
                        end
                    end
                end

                pointCloud = pointCloud(1:counter-1, :);
                pointPlot = plot3(pointCloud(:,1),pointCloud(:,2),pointCloud(:,3),'r.');
                [vertices, volume] = convhull(pointCloud(:,1),pointCloud(:,2),pointCloud(:,3));
                convPlot = trisurf(vertices, pointCloud(:,1), pointCloud(:,2), pointCloud(:,3), 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
                
               
                
                disp(['3D Workspace Volume: ', num2str(volume), ' cubic meters']);
                self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),['3D Workspace Volume: ', num2str(volume), ' cubic meters']}; 
                
                input('Ready for 2D plot?')
                
                delete(pointPlot)
                delete(convPlot)
                
                
                plot(pointCloud(:,1),pointCloud(:,2),'r.');
               

            end
           

            function[brickNumber, initialTransform, vertices] = PlaceBrick(self, transform)
            
            brickNumber = PlaceObject('HalfSizedRedGreenBrick.ply');
            vertices = get(brickNumber,'Vertices');
            initialTransform = transform;
            transformedVertices = [vertices,ones(size(vertices,1),1)] * initialTransform';
            set(brickNumber,'Vertices',transformedVertices(:,1:3));
           
        
           
            end

            function GoToWaypoint(self, waypoint, brickNumber, brickVertices)

                qMatrix = jtraj(self.r.model.getpos(), waypoint,20);

                fingerRotation = troty(pi/2)*trotx(pi/2)*trotz(pi/2);

             for i = 1:20

                self.r.model.animate(qMatrix(i,:));
                self.fingerLeft.model.base = self.r.model.fkine(qMatrix(i,:)).T*fingerRotation;
                self.fingerRight.model.base = self.r.model.fkine(qMatrix(i,:)).T*fingerRotation;

                self.fingerLeft.model.animate(self.fingerLeft.model.getpos());
                self.fingerRight.model.animate(self.fingerRight.model.getpos());

                if nargin > 2
                
                brickTransform = self.r.model.fkine(qMatrix(i,:)).T*transl(0,0,0.1-0.0334);
                transformedVertices = [brickVertices,ones(size(brickVertices,1),1)] * brickTransform';
                set(brickNumber,'Vertices',transformedVertices(:,1:3));
                end

                
                drawnow();

             end

            end
            
            function MoveToBrick(self, brickNumberBase, initialGuess) 
                self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),'The robot is moving to pick up the next brick'}; 
                disp('The robot is moving to pick up the next brick')
                endTransform = brickNumberBase*transl(0, 0, 0.1)*troty(pi);
                actualTransform = self.r.model.fkine(self.r.model.ikcon(endTransform,initialGuess)).T;
                steps = 20;
                qMatrix = jtraj(self.r.model.getpos(),self.r.model.ikcon(endTransform,initialGuess),steps);
                
                fingerRotation = troty(pi/2)*trotx(pi/2)*trotz(pi/2);
                
                self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),['The expected transform was ', self.L.MatrixToString(endTransform)]}; 
                disp('The expected transform was ')
                disp(endTransform)

               

                for i = 1:steps

                    self.r.model.animate(qMatrix(i,:));
                    self.fingerLeft.model.base = self.r.model.fkine(qMatrix(i,:)).T*fingerRotation;
                    self.fingerRight.model.base = self.r.model.fkine(qMatrix(i,:)).T*fingerRotation;

                    self.fingerLeft.model.animate(self.fingerLeft.model.getpos());
                    self.fingerRight.model.animate(self.fingerRight.model.getpos());
                
                    drawnow();

                end

                self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),['The actual transform was ', self.L.MatrixToString(actualTransform)]}; 
                disp('The actual transform was ')
                disp(actualTransform)

            end

            function GoToDropBrick(self, brickCoord, initialGuess, vertices, brickNumber)
                steps = 20;
                self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),'The robot is moving to add the brick to the wall'}; 
                disp('The robot is moving to add the brick to the wall')

                endTransform = transl(brickCoord)*trotz(-pi/2)*troty(pi);
                actualTransform = self.r.model.fkine(self.r.model.ikcon(endTransform,initialGuess)).T;
    
                qMatrix = jtraj(self.r.model.getpos(),self.r.model.ikcon(endTransform, initialGuess),steps);
                fingerRotation = troty(pi/2)*trotx(pi/2)*trotz(pi/2);

                self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),['The expected transform was ', self.L.MatrixToString(endTransform)]}; 
                disp('The expected transform was ')
                disp(endTransform)

            for i = 1:steps


                self.r.model.animate(qMatrix(i,:));
                self.fingerLeft.model.base = self.r.model.fkine(qMatrix(i,:)).T*fingerRotation;
                self.fingerRight.model.base = self.r.model.fkine(qMatrix(i,:)).T*fingerRotation;

                self.fingerLeft.model.animate(self.fingerLeft.model.getpos());
                self.fingerRight.model.animate(self.fingerRight.model.getpos());

                brickTransform = self.r.model.fkine(qMatrix(i,:)).T*transl(0,0,0.1-0.0334);
                transformedVertices = [vertices,ones(size(vertices,1),1)] * brickTransform';
                set(brickNumber,'Vertices',transformedVertices(:,1:3));
                
                drawnow();

            end
            
            self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),['The actual transform was ', self.L.MatrixToString(actualTransform)]}; 
            disp('The actual transform was ')
            disp(actualTransform)

            end
            
            function OpenGripper(self)
                steps = 10;

                self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),'The gripper is opening'}; 
                disp('The gripper is opening')


                qMatrixLeft = jtraj(self.fingerLeft.model.getpos(), [0,deg2rad(10),0], steps);
                qMatrixRight = jtraj(self.fingerRight.model.getpos(), [0,deg2rad(-10),0], steps);

                for i = 1:steps
                    
                    self.fingerLeft.model.animate(qMatrixLeft(i,:));
                    self.fingerRight.model.animate(qMatrixRight(i,:));
                    drawnow()
                end
            
            end

            function CloseGripper(self)
                steps = 10;
                
                self.L.mlog = {self.L.DEBUG,mfilename('IRAssignment1'),'The gripper is closing'}; 
                disp('The gripper is closing')

                qMatrixLeft = jtraj(self.fingerLeft.model.getpos(), [0,0,deg2rad(-15)], steps);
                qMatrixRight = jtraj(self.fingerRight.model.getpos(), [0,0,deg2rad(15)], steps);


                for i = 1:steps
                
                   self.fingerLeft.model.animate(qMatrixLeft(i,:));
                   self.fingerRight.model.animate(qMatrixRight(i,:));
                   drawnow()
                end
            
            end

            function FingerAndArm(self)

                waypoint = [-0.1913,   -1.6800,    0.0137,    1.0865,    0.4706,   -1.5708,    0];
            
                qMatrix = jtraj(self.r.model.getpos(), waypoint,20);

                fingerRotation = troty(pi/2)*trotx(pi/2)*trotz(pi/2);

                for i = 1:20

                self.r.model.animate(qMatrix(i,:));
                self.fingerLeft.model.base = self.r.model.fkine(qMatrix(i,:)).T*fingerRotation;
                self.fingerRight.model.base = self.r.model.fkine(qMatrix(i,:)).T*fingerRotation;

                self.fingerLeft.model.animate([0,deg2rad(i),0]);
                self.fingerRight.model.animate([0,deg2rad(-i),0]);
                
                drawnow()

                    
                end
            end

            
    end



  
end 
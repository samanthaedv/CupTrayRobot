clc;
clf;
clear all;
hold on



%% 
% Define UR3 robot model
r = UR3e; 
global e_stop;


EnvironmentInitialise;

environment = struct('model', {}, 'vertices', {}, 'transform', {});


 obstacleModel = PlaceObject('baby.ply');
    vertices = [get(obstacleModel, 'Vertices'), ones(size(get(obstacleModel, 'Vertices'), 1), 1)];
    obstacleTransform = transl(0, -0.5, 0.9);
    obstacleVertices = vertices * obstacleTransform';
    set(obstacleModel, 'Vertices', obstacleVertices(:, 1:3));
    

plotOptions.plotVerts = false; % Set to true if you want to show vertices
plotOptions.plotEdges = true;  % Set to true to show edges
plotOptions.plotFaces = false; % Set to false to hide faces

[v,f,fn] = RectangularPrism([-0.25,-0.9,0.90], [0.25,-0.1,1.40], plotOptions);    %on the bottom side south

flipMatrix = [-1, 0, 0, 0;
             0, 1, 0, 0;
             0, 0, -1, 0;
             0, 0, 0, 1];
r.model.base = [1,0,0,0.4;
     0,1,0,0;
     0,0,1,0.9;
     0,0,0,1];
tray1 = Tray([1,0,0,0;
     0,1,0,0;
     0,0,1,0.9;
     0,0,0,1]);


q0 = [ 0   -pi/2    pi/4    -pi/4 -pi/2 0];
q2 = [ pi   -pi/2    pi/4    -pi/4 -pi/2 0];

r.model.animate(q2)









depotTransform = [0,	-1,	0,	0.8708;
                 -1,	0,	0,	0.132;
                 0,	0,	-1,	1.15;
                 0,	0,	0,	1];
gripperOffset = [1,0,0,0;
                 0,1,0,0;
                 0,0,1,-0.25;
                 0,0,0,1];

global e_stop;
e_stop = false;

% Create the e-stop button
eStopButton = uicontrol('Style', 'pushbutton', 'String', 'Toggle E-Stop', ...
                        'Position', [20, 20, 100, 30], ... % Position on figure
                        'Callback', @toggleEStop); % Callback to handle button press

% Define the callback function for toggling the e-stop
function toggleEStop(~, ~)
    global e_stop;
    e_stop = ~e_stop;  % Toggle the e-stop state
    if e_stop
        disp('E-stop activated');
        set(eStopButton, 'String', 'E-Stop Active'); % Update button text
    else
        disp('E-stop deactivated');
        set(eStopButton, 'String', 'Toggle E-Stop'); % Reset button text
    end
end




for i = 1:6
    q1 = r.model.ikcon(tray1.cups(i).currentTransform*gripperOffset, q0);
moveRobotCollisionTest(r,q2,q0, f, v, fn);

moveRobotCollisionTest(r,q0,q1, f, v, fn);

moveRobotGrip(r,q1,q0,tray1.cups(i), environment);

moveRobotGrip(r,q0,q2,tray1.cups(i), environment);

depotTransform = depotTransform * [1,0,0,0;
                              0,1,0,0;
                              0,0,1,-0.01;
                              0,0,0,1]; 
q3 = r.model.ikcon(depotTransform, q2);
moveRobotGrip(r,q2,q3,tray1.cups(i), environment);

moveRobotCollisionTest(r,q3,q2, f, v, fn);



end
%{
box2Pose = [eye(3), [-0.32,-0.2,0.2]'; 0, 0, 0, 1] ; 
box3Pose = [eye(3), [-0.1,-0.2,0.2]'; 0, 0, 0, 1]* flipMatrix;  % in mid 
box4Pose = [eye(3), [-0.3,-0.32,0.151]'; 0, 0, 0, 1]* flipMatrix; 
box5Pose = [eye(3), [-0.32,-0.32,0.2]'; 0, 0, 0, 1]* flipMatrix; 
box6Pose = [eye(3), [0.3,-0.32,0.2]'; 0, 0, 0, 1]* flipMatrix; 
box7Pose = [eye(3), [0.45,-0.2,0.2]'; 0, 0, 0, 1]* flipMatrix; 
q0 = zeros(1,6);
steps = 500;

q5 = r.model.ikcon(box6Pose); 
qtraj1 = jtraj(q0, q5, steps);
for i = 1:size(qtraj1, 1)
    next_q = qtraj1(i,:);
    result = IsCollision(r,next_q,f,v,fn);
    r.model.animate(next_q);
    drawnow();
    pause(0);
    
    if result == 1
        disp('Collision! Finding alternative route.');
        rposition = r.model.getpos();
        disp(next_q)
        break
    end
end

q2 = r.model.ikcon(box2Pose); 
qtraj2 = jtraj(next_q, q2, steps);
for i = 1:size(qtraj2, 1)
    now_q1 = qtraj2(i,:);
    r.model.animate(now_q1);
    drawnow();
    pause(0);

end 
q3 = r.model.ikcon(box3Pose); 
qtraj3 = jtraj(now_q1, q3, steps);
for i = 1:size(qtraj3, 1)
    now_q2 = qtraj3(i,:);
    r.model.animate(now_q2);
    drawnow();
    pause(0);

end 
%q4 = r.model.ikcon(box4Pose); 
qtraj4 = jtraj(q3, q5, steps);
for i = 1:size(qtraj4, 1)
    now_q3 = qtraj4(i,:);
    r.model.animate(now_q3);
    drawnow();
    pause(0);
end 
q6 = r.model.ikcon(box7Pose); 
qtraj5 = jtraj(q5, q6, steps);
for i = 1:size(qtraj4, 1)
    now_q4 = qtraj5(i,:);
    result1 = IsCollision(r,now_q4,f1,v1,fn1);
    
     if result1 == 1
        disp('Collision! Finding alternative route.');
            e_stop = true;
        break
    end
end 

%}
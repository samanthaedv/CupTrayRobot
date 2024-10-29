clc;
clf;
clear all;
hold on;
axis([-2 2 -2 2 -1 3])

EnvironmentInitialise;

environment = struct('model', {}, 'vertices', {}, 'transform', {});


 obstacleModel = PlaceObject('baby.ply');
    vertices = [get(obstacleModel, 'Vertices'), ones(size(get(obstacleModel, 'Vertices'), 1), 1)];
    obstacleTransform = transl(0, -0.5, 0.9);
    obstacleVertices = vertices * obstacleTransform';
    set(obstacleModel, 'Vertices', obstacleVertices(:, 1:3));
    environment(end+1).model = obstacleModel;
    environment(end).vertices = obstacleVertices(:, 1:3);
    environment(end).transform = obstacleTransform;

tray1 = Tray([1,0,0,0;
     0,1,0,0;
     0,0,1,0.9;
     0,0,0,1]);

r = UR3e;
r.model.base = [1,0,0,0.4;
     0,1,0,0;
     0,0,1,0.9;
     0,0,0,1];






q0 = [ 0   -pi/2    pi/4    -pi/4 -pi/2 0];

r.model.animate(q0)









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

q2 = [ pi   -pi/2    pi/4    -pi/4 -pi/2 0];
moveRobot(r,q0,q1, environment);

moveRobotGrip(r,q1,q0,tray1.cups(i), environment);

moveRobotGrip(r,q0,q2,tray1.cups(i), environment);

depotTransform = depotTransform * [1,0,0,0;
                              0,1,0,0;
                              0,0,1,-0.01;
                              0,0,0,1]; 
q3 = r.model.ikcon(depotTransform, q2);
moveRobotGrip(r,q2,q3,tray1.cups(i), environment);

moveRobot(r,q3,q2, environment);

moveRobot(r,q2,q0, environment);

end
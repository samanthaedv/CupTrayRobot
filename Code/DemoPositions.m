clc;
clf;
clear all;
hold on;
axis([-2 2 -2 2 -1 3])



environment = Environment;
%{
    obstacleModel = PlaceObject('baby.ply');
    vertices = [get(obstacleModel, 'Vertices'), ones(size(get(obstacleModel, 'Vertices'), 1), 1)];
    obstacleTransform = transl(0, -0.5, 0.9);
    obstacleVertices = vertices * obstacleTransform';
    set(obstacleModel, 'Vertices', obstacleVertices(:, 1:3));
    environment(end+1).model = obstacleModel;
    environment(end).vertices = obstacleVertices(:, 1:3);
    environment(end).transform = obstacleTransform;
%} 
%its a obstacle baby 


   
    

tray1 = Tray([1,0,0,-0.25;
     0,1,0,0;
     0,0,1,0.4;
     0,0,0,1]);

r = UR3e;
r.model.base = [1,0,0,0.4;
     0,1,0,0;
     0,0,1,0.9;
     0,0,0,1];
rUs = URTray;

rUs.model.base = [1,0,0,-1.5;
     0,1,0,-1.15;
     0,0,1,0;
     0,0,0,1]* trotx(pi/2) * troty(-pi/2);


q0 = [ 0   -pi/2    pi/4    -pi/4 -pi/2 0];

r.model.animate(q0)
qR0 = [-0.1 -0.3 0   -pi/2    pi/4    -pi/4 -pi/2 0];


rUs.model.animate(qR0);





depotTransform = [0,	-1,	0,	0.8708;
                 -1,	0,	0,	0.132;
                 0,	0,	-1,	0.95;
                 0,	0,	0,	1];
gripperOffset = [1,0,0,0;
                 0,1,0,0;
                 0,0,1,0;
                 0,0,0,1];
%{
qT = [1,0,0,-0.25;
     0,1,0,-0.5;
     0,0,1,0.5;
     0,0,0,1]* trotx(pi/2) * troty(-pi/2);


moveRobotRMRC(rUs,qR0,qT,100,0.02);
%}

global e_stop;
e_stop = false;

% Create the e-stop button
eStopButton = uicontrol('Style', 'pushbutton', 'String', 'Toggle E-Stop', ...
                        'Position', [20, 20, 200, 50], ...
                        'BackgroundColor', [1 0 0], ...
                        'FontSize',  18, ...
                        'FontWeight', 'bold', ...
                        'ForegroundColor', 'white', ...
                        'Callback', @toggleEStop);

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





qR1 = rUs.model.ikcon(tray1.currentTransform*[1,0,0,0; ...
                                              0,1,0,-0.5; ...
                                              0,0,1,0; ...
                                              0,0,0,1] *trotz(pi/2)*troty(pi/2), qR0);
moveRobot(rUs,qR0,qR1);

qR2 = rUs.model.ikcon(tray1.currentTransform*[1,0,0,0; ...
                                              0,1,0,-0.25; ...
                                              0,0,1,0; ...
                                              0,0,0,1] *trotz(pi/2)*troty(pi/2), qR1);
moveRobot(rUs,qR1,qR2);

moveRobotTray(rUs,qR2,qR1,tray1);
qR4 = [-0.5 -0.3 -pi/6   -pi/2    -pi/4    pi/4 -pi/2 pi/6];
moveRobotTray(rUs,qR1,qR4,tray1);

qR5 = [-0.5 -1.5 pi/6   -pi/2    -pi/4    pi/4 -pi/2 -pi/6];
moveRobotTray(rUs,qR4,qR5,tray1);
qR6 = rUs.model.ikcon([1,0,0,0;
                      0,1,0,0;
                      0,0,1,0.9;
                      0,0,0,1]*[1,0,0,0; ...
                                              0,1,0,-0.25; ...
                                              0,0,1,0.15; ...
                                              0,0,0,1] *trotz(pi/2)*troty(pi/2), qR5);
moveRobotTray(rUs,qR5,qR6,tray1);

for i = 1:6
    q1 = r.model.ikcon(tray1.cups(i).currentTransform*gripperOffset, q0);

q2 = [ pi   -pi/2    pi/4    -pi/4 -pi/2 0];
q6 = [ pi   -pi/4    pi/4    -pi/2 -pi/2 0];
moveRobot(r,q0,q1);

moveRobotGrip(r,q1,q0,tray1.cups(i));

moveRobotGrip(r,q0,q2,tray1.cups(i));
moveRobotGrip(r,q2,q6,tray1.cups(i));

depotTransform = depotTransform * [1,0,0,0;
                              0,1,0,0;
                              0,0,1,-0.01;
                              0,0,0,1]; 
q3 = r.model.ikcon(depotTransform, q6);
moveRobotGrip(r,q6,q3,tray1.cups(i));

moveRobot(r,q3,q2);

moveRobot(r,q2,q0);

end



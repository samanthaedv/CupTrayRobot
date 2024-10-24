clc;
clf;
clear all;
hold on;
axis([-2 2 -2 2 -1 3])

Bench([1,0,0,0;
      0,1,0,0;
      0,0,1,0;
      0,0,0,1]);
tray1 = Tray([1,0,0,0;
     0,1,0,0;
     0,0,1,0.9;
     0,0,0,1]);

r = UR3e;
r.model.base = [1,0,0,0.4;
     0,1,0,0;
     0,0,1,0.9;
     0,0,0,1];
rUs = URTray;

rUs.model.base = [1,0,0,0;
     0,1,0,-1.25;
     0,0,1,0;
     0,0,0,1]* trotx(pi/2) * troty(-pi/2);

q_log = [];

q0 = [ 0   -pi/2    pi/4    -pi/4 -pi/2 0];
q_log = [q_log; q0];
r.model.animate(q0)
qR0 = [-0.1 -0.3 0   -pi/2    pi/4    -pi/4 -pi/2 0];
rUs.model.animate(qR0);
depotTransform = [0,	-1,	0,	0.8708;
                 -1,	0,	0,	0.13105;
                 0,	0,	-1,	1.15;
                 0,	0,	0,	1];
gripperOffset = [1,0,0,0;
                 0,1,0,0;
                 0,0,1,-0.25;
                 0,0,0,1];




for i = 1:6
    q1 = r.model.ikcon(tray1.cups(i).currentTransform * gripperOffset , q0);

q2 = [ pi   -pi/2    pi/4    -pi/4 -pi/2 0];
moveRobot(r,q0,q1);
q_log = [q_log; q1];
moveRobotGrip(r,q1,q0,tray1.cups(i));
q_log = [q_log; q0];
moveRobotGrip(r,q0,q2,tray1.cups(i));
q_log = [q_log; q2];
depotTransform = depotTransform * [1,0,0,0;
                              0,1,0,0;
                              0,0,1,-0.01;
                              0,0,0,1] 
q3 = r.model.ikcon(depotTransform, q2);
moveRobotGrip(r,q2,q3,tray1.cups(i));
q_log = [q_log; q3];
moveRobot(r,q3,q2);
q_log = [q_log; q2];
moveRobot(r,q2,q0);
q_log = [q_log; q0];
end

save('q_log.mat', 'q_log');

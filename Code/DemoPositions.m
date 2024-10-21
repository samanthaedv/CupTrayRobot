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

q0 = [ 0   -pi/4    pi/4    -pi/2 -pi/2 0];
r.model.animate(q0)

depotTransform = [0,	-1,	0,	0.8708;
                 -1,	0,	0,	0.13105;
                 0,	0,	-1,	0.95;
                 0,	0,	0,	1];





for i = 1:6
    q1 = r.model.ikcon(tray1.cups(i).currentTransform, q0);

q2 = [ pi   -pi/4    pi/4    -pi/2 -pi/2 0];
moveRobot(r,q0,q1);
moveRobotGrip(r,q1,q0,tray1.cups(i));
moveRobotGrip(r,q0,q2,tray1.cups(i));
depotTransform = depotTransform * [1,0,0,0;
                              0,1,0,0;
                              0,0,1,-0.01;
                              0,0,0,1] 
q3 = r.model.ikcon(depotTransform, q2);
moveRobotGrip(r,q2,q3,tray1.cups(i));
moveRobot(r,q3,q2);
moveRobot(r,q2,q0);
end


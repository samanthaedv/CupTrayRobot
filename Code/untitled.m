clc;
clear all;
hold on;
axis([-4 4 -4 4 -1 4])


Bench([1,0,0,0;
      0,1,0,-3;
      0,0,1,0;
      0,0,0,1]);
Tray([1,0,0,3;
     0,1,0,3;
     0,0,1,0;
     0,0,0,1]);

rob1 = URTray;
rob1.model.base = ([1,0,0,3;
                    0,1,0,0; ...
                    0,0,1,0; ...
                    0,0,0,1]) * trotx(pi/2) * troty(pi/2);
qR0 = [-0.1 -0.31 0   -pi/2    pi/4    -pi/4 -pi/2 0];
rob1.model.animate(qR0)
clc;
clf;
clear all;
hold on;
axis([-2 2 -2 2 -1 3])

Bench([1,0,0,0;
      0,1,0,0;
      0,0,1,0;
      0,0,0,1]);
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

URTrayGUI(rUs.model, r.model);
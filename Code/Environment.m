function Environment

clc;
clf;
clear all;
hold on;
axis([-2 2 -2 2 -1 3])

Bench([1,0,0,0;
      0,1,0,0;
      0,0,1,0;
      0,0,0,1]);

firstAidModel = PlaceObject('FirstAidKit.ply')
vertices = [get(firstAidModel,'Vertices'), ones(size(get(firstAidModel,'Vertices'),1),1)];
            transformedVertices = vertices*transl(-0.7,12,8.4)'*0.25;
set(firstAidModel,'Vertices',transformedVertices(:,1:3));


eStopModel = PlaceObject('estop.ply')
vertices = [get(eStopModel,'Vertices'), ones(size(get(eStopModel,'Vertices'),1),1)];
            transformedVertices = vertices*transl(0,0,1)';
set(eStopModel,'Vertices',transformedVertices(:,1:3));

drawnow;





end
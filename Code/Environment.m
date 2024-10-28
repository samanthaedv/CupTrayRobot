function Environment

clc;
clf;
clear all;
hold on;
% axis([-2 2 -2 2 -1 3])
% 
% Bench([1,0,0,0;
%       0,1,0,0;
%       0,0,1,0;
%       0,0,0,1]);

firstAidModel = PlaceObject('FirstAidKit.ply')
% PlaceObject('estop.ply')
% 
% 
vertices = [get(firstAidModel,'Vertices'), ones(size(get(firstAidModel,'Vertices'),1),1)];
            transformedVertices = vertices;
% 
   set(firstAidModel,'Vertices',transformedVertices(:,1:3));

            drawnow;





end
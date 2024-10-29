function Environment

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
            transformedVertices = vertices*(transl(1.4,-0.4,0.9)*trotx(pi/2))';
set(eStopModel,'Vertices',transformedVertices(:,1:3));


spillKitModel = PlaceObject('SpillKit.ply')
vertices = [get(spillKitModel,'Vertices'), ones(size(get(spillKitModel,'Vertices'),1),1)];
            transformedVertices = vertices*(transl(2.3,-0.2,0)*trotx(pi/2)*troty(pi))'*0.75;
set(spillKitModel,'Vertices',transformedVertices(:,1:3));


drawnow;




end
function Environment

hold on;
% axis([-2 2 -2 2 -1 3])

Bench([1,0,0,0;
      0,1,0,0;
      0,0,1,0;
      0,0,0,1]);

firstAidModel = PlaceObject('FirstAidKit.ply')
vertices = [get(firstAidModel,'Vertices'), ones(size(get(firstAidModel,'Vertices'),1),1)];
            transformedVertices = vertices*transl(-0.7,16,6.5)'*0.25;
set(firstAidModel,'Vertices',transformedVertices(:,1:3));


eStopModel = PlaceObject('estop.ply')
vertices = [get(eStopModel,'Vertices'), ones(size(get(eStopModel,'Vertices'),1),1)];
            transformedVertices = vertices*(transl(1.4,1,0.43)*trotx(pi/2))';
set(eStopModel,'Vertices',transformedVertices(:,1:3));


spillKitModel = PlaceObject('SpillKit.ply')
vertices = [get(spillKitModel,'Vertices'), ones(size(get(spillKitModel,'Vertices'),1),1)];
            transformedVertices = vertices*(transl(1,1.5,0)*trotx(pi/2)*troty(pi))'*0.75;
set(spillKitModel,'Vertices',transformedVertices(:,1:3));

fence = PlaceObject('fencetest.ply');
 vertices = [get(fence,'Vertices'), ones(size(get(fence,'Vertices'),1),1)];
            transformedVertices = vertices*(transl(-1.5,-3,0.8)*trotx(pi/2))';
            set(fence,'Vertices',transformedVertices(:,1:3));
transformedVertices(:,2) = transformedVertices(:,2)*0.75 ;
set(fence,'Vertices',transformedVertices(:,1:3));


table = PlaceObject('table.ply');
vertices = [get(table,'Vertices'), ones(size(get(table,'Vertices'),1),1)];
            transformedVertices = vertices*(transl(1.3,1.1,0))';
            set(table,'Vertices',transformedVertices(:,1:3));


drawnow;




end
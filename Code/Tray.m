classdef Tray 

    properties
       
        trayModel
        vertices
        currentTransform
        cups

    end

    methods
        function obj = Tray(initialTransform)
            obj.currentTransform = initialTransform; %To get the tray rotated correctly trotx(pi/2)
            obj.trayModel = PlaceObject('trayResize.ply'); %places the tray
            %PlaceObject() can only take in a position not a transform.
            %Therefore place the tray at origin and transform vertices to
            %the initial transform
            obj.vertices = [get(obj.trayModel,'Vertices'), ones(size(get(obj.trayModel,'Vertices'),1),1)];
            transformedVertices = obj.vertices * initialTransform';
            
            set(obj.trayModel,'Vertices',transformedVertices(:,1:3));

            cupLocation = [-0.1 , -0.06, 0;
                0, -0.06, 0;
                0.1, -0.06, 0;
                -0.1, 0.06, 0;
                0, 0.06, 0;
                0.1, 0.06, 0;
                ];
            obj.cups = Cup.empty(6, 0); 
            for i = 1:6
                initialTransformCup = initialTransform * [1, 0, 0, cupLocation(i,1);
                                       0, -1, 0, cupLocation(i,2);
                                       0, 0, -1, cupLocation(i,3)+0.07;
                                       0, 0, 0, 1];
                obj.cups(i) = Cup(initialTransformCup);
            end

        end

        function TrayMove(obj, destinationTransform)

            obj.currentTransform = destinationTransform;
            transformedVertices = [obj.vertices,ones(size(obj.vertices,1),1)] * obj.currentTransform';
            set(obj.trayModel,'Vertices',transformedVertices(:,1:3));

        end
    end 

end

classdef Tray 

    properties
       
        trayModel
        vertices
        currentTransform
        cups

    end

    methods
        function obj = Tray(initialTransform)
            obj.currentTransform = initialTransform; 
            obj.trayModel = PlaceObject('tray.ply',initialTransform); %places the tray
            obj.vertices = [get(obj.trayModel,'Vertices'), ones(size(get(obj.trayModel,'Vertices'),1),1)];

            cupLocation = [-0.02 , 0, -0.02;
                -0.02, 0, 0;
                -0.02, 0, 0.02;
                0.02, 0, -0.02;
                0.02, 0, 0;
                0.02, 0, 0.02;
                ];

            for i = 1:6
                initialTransformCup = [1, 0, 0, cupLocation(i,1);
                                       0, 1, 0, cupLocation(i,2);
                                       0, 0, 1, cupLocation(i,3);
                                       0, 0, 0, 1];
                cups(i) = Cup(initialTransformCup);
            end

        end

        function TrayMove(obj, destinationTransform)

            obj.currentTransform = destinationTransform;
            transformedVertices = [obj.vertices,ones(size(obj.vertices,1),1)] * obj.currentTransform';
            set(obj.trayModel,'Vertices',transformedVertices(:,1:3));

        end
    end 

end

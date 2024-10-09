classdef Cup 

    properties
       
        cupModel
        vertices
        currentTransform   

    end

    methods
        function obj = PlaceCup(initialTransform)
            obj.currentTransform = initialTransform; 
            obj.cupModel = PlaceObject('cup.ply',obj.initialTransform); %places the cup %check if place object can take in tranform
            obj.vertices = [get(obj.cupModel,'Vertices'), ones(size(get(obj.cupModel,'Vertices'),1),1)];

        end

        function CupMove(obj, destinationTransform)

            obj.currentTransform = destinationTransform;
            transformedVertices = [obj.vertices,ones(size(obj.vertices,1),1)] * obj.currentTransform';
            set(obj.cupModel,'Vertices',transformedVertices(:,1:3));

        end
    end 

end

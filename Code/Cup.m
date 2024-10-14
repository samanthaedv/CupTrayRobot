classdef Cup 

    properties
       
        cupModel
        vertices
        currentTransform   

    end

    methods
        function obj = Cup(initialTransform)
            obj.currentTransform = initialTransform; 
            obj.cupModel = PlaceObject('cup.ply'); %places the cup
            %PlaceObject() can only take in a position not a transform.
            %Therefore place the cup at origin and transform vertices to
            %the initial transform
            obj.vertices = [get(obj.cupModel,'Vertices'), ones(size(get(obj.cupModel,'Vertices'),1),1)];
            transformedVertices = obj.vertices * initialTransform';
            set(obj.cupModel,'Vertices',transformedVertices(:,1:3));

        end

        function CupMove(obj, destinationTransform)

            obj.currentTransform = destinationTransform;
            transformedVertices = [obj.vertices,ones(size(obj.vertices,1),1)] * obj.currentTransform';
            set(obj.cupModel,'Vertices',transformedVertices(:,1:3));

        end
    end 

end

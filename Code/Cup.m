classdef Cup < handle

    properties
       
        model
        vertices
        currentTransform   

    end

    methods
        function obj = Cup(initialTransform)
            obj.currentTransform = initialTransform; 
            obj.model = PlaceObject('Cup.ply'); %places the cup
            %PlaceObject() can only take in a position not a transform.
            %Therefore place the cup at origin and transform vertices to
            %the initial transform
            obj.vertices = [get(obj.model,'Vertices'), ones(size(get(obj.model,'Vertices'),1),1)];
            transformedVertices = obj.vertices * initialTransform';
            set(obj.model,'Vertices',transformedVertices(:,1:3));

        end

        function CupMove(obj, destinationTransform)

            obj.currentTransform = destinationTransform;
            newVerts1 = (obj.vertices(:,1:3) * destinationTransform(1:3,1:3)') + destinationTransform(1:3,4)';
            set(obj.model, 'Vertices', newVerts1);

        end
    end 

end

classdef Bench 

    properties
       
        benchModel
        vertices
        currentTransform   

    end

    methods
        function obj = Bench(initialTransform)
            obj.currentTransform = initialTransform; 
            obj.benchModel = PlaceObject('bench.ply'); %places the cup
            %PlaceObject() can only take in a position not a transform.
            %Therefore place the cup at origin and transform vertices to
            %the initial transform
            obj.vertices = [get(obj.benchModel,'Vertices'), ones(size(get(obj.benchModel,'Vertices'),1),1)];
            transformedVertices = obj.vertices * initialTransform';
            
            set(obj.benchModel,'Vertices',transformedVertices(:,1:3));

        end

        function BenchMove(obj, destinationTransform)

            obj.currentTransform = destinationTransform;
            transformedVertices = [obj.vertices,ones(size(obj.vertices,1),1)] * obj.currentTransform';
            set(obj.benchModel,'Vertices',transformedVertices(:,1:3));

        end
    end 

end

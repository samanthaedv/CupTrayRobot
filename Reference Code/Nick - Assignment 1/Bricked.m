classdef Bricked
    %BRICKCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        POS
        verts
        model
        ORI
        destinationPOS
        destinationORI

    end
    
    methods
        function obj = Bricked(inPOS,indestinationPOS)
            obj.POS = inPOS; %storage variable - -0.4 (x), 0.4 (y), 0 (z)
            obj.model = PlaceObject('HalfSizedRedGreenBrick.ply',obj.POS); %places the brick
            obj.verts = [get(obj.model,'Vertices'), ones(size(get(obj.model,'Vertices'),1),1)];


            %Brick 1
            obj.ORI = eye(3); % Identity matrix for no rotation
            obj.destinationORI = eye(3);
            obj.destinationPOS = indestinationPOS;
            % Create a 4x4 transformation matrix for the brick's initial pose
            % Apply a 180-degree rotation around the X-axis to flip the orientation
            % for end's effector pointing downward
            flipMatrix = [1, 0, 0, 0;
                0, -1, 0, 0;
                0, 0, -1, 0;
                0, 0, 0, 1];
            obj.POS = [obj.ORI, obj.POS'; 0, 0, 0, 1]; %The last row for homogeneous coordinates
            obj.destinationPOS = [obj.destinationORI, obj.destinationPOS'; 0, 0, 0, 1];
            % Apply the rotation to the original 'brick1_POS'
            obj.POS = obj.POS * flipMatrix;
            obj.destinationPOS = obj.destinationPOS * flipMatrix;

        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end


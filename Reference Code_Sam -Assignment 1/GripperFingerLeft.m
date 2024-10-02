classdef GripperFingerLeft < RobotBaseClass
    %% 

     properties(Access = public)              
         plyFileNameStem = 'GripperFingerLeft';
     end
    % 
    methods
%% Define robot Function 
    function self = GripperFingerLeft(baseTr)
			self.CreateModel();
             if nargin < 1			
			 	baseTr = eye(4);				
             end
             self.model.base = self.model.base.T * baseTr; %* trotx(pi/2) * troty(pi/2);
            % 
           
             self.PlotAndColourRobot();         
        end

%% Create the robot model
        function CreateModel(self)   
           
            link(1) = Link('d', 0, 'a', -0.05, 'alpha', 0, 'qlim', 0);
            link(2) = Link('d', 0, 'a', 0.05, 'alpha', 0, 'qlim', deg2rad([0 90]), 'offset', pi/2);
            link(3) = Link('d', 0, 'a', 0.05, 'alpha', 0, 'qlim', deg2rad([-90 0]));

            
            
            % Incorporate joint limits
            link(1).qlim = 0;
            link(2).qlim = [0 90]*pi/180;
            link(3).qlim = [-90 0]*pi/180;
            
            
            self.model = SerialLink(link,'name',self.name);
        end
     
    end
end
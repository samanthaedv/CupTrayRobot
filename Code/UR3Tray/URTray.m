classdef URTray < RobotBaseClass
    %% LinearUR5 UR5 on a non-standard linear rail created by a student

    properties(Access = public)              
        plyFileNameStem = 'URTray';
    end
    
    methods
%% Define robot Function 
function self = URTray(baseTr)
			self.CreateModel();
            if nargin < 1			
				baseTr = eye(4);				
            end
            self.model.base = self.model.base.T * baseTr * trotx(pi/2) * troty(pi/2);
            
            self.PlotAndColourRobot();         
        end

%% Create the robot model
        function CreateModel(self)   
            % Create the UR5 model mounted on a linear rail
            link(1) = Link([pi     1       0       -pi/2    1]); % PRISMATIC Link
            link(2) = Link([pi/2     0       0       pi/2    1]); % PRISMATIC Link
     
           
            link(3) = Link('d',0.15185,'a',0,'alpha',pi/2,'qlim',deg2rad([-360, 360]), 'offset',0);
            link(4) = Link('d',0,'a',-0.24355,'alpha',0,'qlim', deg2rad([-360, 360]), 'offset',0);
            link(5) = Link('d',0,'a',-0.2132,'alpha',0,'qlim', deg2rad([-360, 360]), 'offset', 0);
            link(6) = Link('d',0.13105,'a',0,'alpha',pi/2,'qlim',deg2rad([-360, 360]),'offset', 0);
            link(7) = Link('d',0.08535,'a',0,'alpha',-pi/2,'qlim',deg2rad([-360,360]), 'offset',0);
            link(8) = Link('d',	0.0921,'a',0,'alpha',0,'qlim',deg2rad([-360,360]), 'offset', 0);
            
            % Incorporate joint limits
            link(1).qlim = [-0.8 -0.01];
            link(2).qlim = [-0.8 -0.01];
            link(3).qlim = [-360 360]*pi/180;
            link(4).qlim = [-90 90]*pi/180;
            link(5).qlim = [-170 170]*pi/180;
            link(6).qlim = [-360 360]*pi/180;
            link(7).qlim = [-360 360]*pi/180;
            link(8).qlim = [-360 360]*pi/180;
        
            
            link(4).offset = -pi/2;
            link(6).offset = -pi/2;
            
            self.model = SerialLink(link,'name',self.name);
        end
     
    end
end
function LightCurtain(fence, robot)

    global e_stop;
    e_stop = false;
    hold on;
    
    fenceVertices = [get(fence,'Vertices'), ones(size(get(fence,'Vertices'),1),1)];
   
    yVertices = fenceVertices(:, 2);
    minValue = min(yVertices);
    maxValue = max(yVertices);
    
    
    person = PlaceObject('bob.ply');
    vertices = [get(person,'Vertices'), ones(size(get(person,'Vertices'),1),1)];
    transformedVertices = vertices*(transl(0,0.8,0.05)*trotx(pi/2))'*1.5;
    set(person,'Vertices',transformedVertices(:,1:3));
    
    
    startValue = 0.8;
    endValue = 0.5;
    stepSize = (endValue - startValue) / 20;
    
    %animate person moving to fence
    for i = 0:20
        
        currentValue = startValue + i * stepSize;
        transformedVertices = vertices*(transl(0,currentValue,0.05)*trotx(pi/2))'*1.5;
        set(person,'Vertices',transformedVertices(:,1:3));
        q1 = robot.model.getpos();
        q1(1) = -currentValue;
        
        if e_stop == false
            robot.model.animate(q1);
        end 
        
        drawnow;
       
        yPerson = transformedVertices(:, 2);
        curtainTriggered = any(yPerson >= minValue & yPerson <= maxValue); %check if curtain triggered
    
   
    
        if curtainTriggered %stop the system
         e_stop = true;
        disp('Light Curtain Triggered');
   
       end
        
    end
    
    
    
end

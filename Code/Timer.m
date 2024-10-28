t = timer('ExecutionMode', 'fixedRate', 'Period', 1, 'TimerFcn', {@myCallback});
start(t);

function myCallback(~, ~)
    disp('Timer event triggered');
    %buttonPress = readDigitalPin(a,'D10');
    %buttonStore = [buttonStore(2:end) buttonPress]
    % 
    % if buttonStore(1) == 1 && buttonStore(2) == 1 && buttonStore(3) == 1 %Acting as a sort of debounce because button was very sensitive
    % systemRunning=0 
    % end
   % 
   % buttonPress = readDigitalPin(a,'D10');
   % disp(buttonPress)
   % % 
   % if buttonStore(1) == 1 && buttonStore(2) == 1 && buttonStore(3) == 1 %Acting as a sort of debounce because button was very sensitive
   %  systemRunning=0 



   %  end
   % end

   
end
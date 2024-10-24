
systemRunning = 1;
buttonStore = zeros(1,3);
a = arduino;

while (systemRunning ==1)


buttonPress = readDigitalPin(a,'D10');
buttonStore = [buttonStore(2:end) buttonPress]

disp(buttonPress)

if buttonStore(1) == 1 && buttonStore(2) == 1 && buttonStore(3) == 1 %Acting as a sort of debounce because button was very sensitive
    systemRunning=0 
end
end



if systemRunning ==0
    answer = input("Do you want to continue? Yes or No?", "s")
    
    if answer == "Yes"
        disp('Okay Robot Running')
    end

end
    
function [xOut,yOut] = batPos(x,y)
    randNum =  (4 * rand()); %generates a random number between 1 and 4 
    %default x and y values 
    xOut = x;
    yOut = y;
    

    %If else ladder for seeing if the bat will move up down left or right 
    if randNum >= 3
        xOut = x + 1; 
    elseif randNum >= 2
        xOut = x - 1;
    elseif randNum >= 1 
        yOut = y + 1 ;
    elseif randNum >= 0 
         yOut = y - 1;
    end 

    %Cases to check if the bat is moving out of bounds 
    if xOut <= 0
        xOut = 1;
    end 
    if yOut <= 0 
        yOut = 1;
    end 
    if yOut > 11
        yOut = 11;
    end 
    if xOut > 11
        xOut = 11;
    end 
end
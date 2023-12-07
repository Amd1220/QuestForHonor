function [xOut,yOut] = firePos(x,y)
    %Bat position code, changed to say firePos for clearer code
    randNum =  (4 * rand());
    xOut = x;
    yOut = y;
    if randNum >= 3
        xOut = x + 1;
     
    elseif randNum >= 2
        xOut = x - 1;
    elseif randNum >= 1 
        yOut = y + 1 ;
    elseif randNum >= 0 
         yOut = y - 1;
    end 
    if xOut <= 0
        xOut = 1;
    end 
    if yOut <= 0 
        yOut = 1;
    end 
    if yOut > 10
        yOut = 10;
    end 
    if xOut > 10
        xOut = 10;
    end 
end
function [mazeComplete] = maze(~)
 warning('off','all'); 
 clc
mazeComplete = 0; 
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);
player_sprite = 28;
blank_sprite = 1;
floor_tile = 1;
maze_tile = 18*32 + 13;
key = 23*32 + 17;
lock = 32+24;

%Places the sprites for scene 1
gameboard_display1 = blank_sprite * ones(21,21);
gameboard_display1(2,1) = player_sprite;
%Creates the room backgrounds
rooms_display1 = floor_tile * ones(21,21);
%Maze layout, ones represent the walls of the maze, 0 represents blank spaces, 2 represents the key
maze = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
        0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1;
        1,0,1,1,1,0,1,0,1,0,1,1,1,1,1,1,1,0,1,0,1;
        1,0,1,0,0,0,1,0,1,0,1,0,1,0,0,0,0,0,1,0,1;
        1,0,1,1,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,0,1;
        1,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,1,0,1,0,1;
        1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
        1,0,1,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,1;
        1,0,1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1;
        1,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,0,0,0,1;
        1,0,1,1,1,0,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1;
        1,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,1,0,0,0,1;
        1,1,1,1,1,1,1,0,1,1,1,0,1,1,1,1,1,1,1,0,1;
        1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1;
        1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,0,1;
        1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1;
        1,0,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,0,1,0,1;
        1,0,1,0,1,0,1,2,1,0,0,0,1,0,1,0,0,0,0,0,1;
        1,0,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,1,1,1,1;
        1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,3;
        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
%Nested for that runs through background to place the walls and key 
for i = 1:21
    for j = 1:21
        if maze(i,j) == 1
            rooms_display1(i,j) = maze_tile;
        end 
        if maze(i,j) == 2
            gameboard_display1(i,j) = key;
        end 
        if maze(i,j) == 3
            rooms_display1(i,j) = lock;
        end 
    end 
end 


y = 2;
x = 1;
input = 'a';
drawScene(my_scene1,rooms_display1,gameboard_display1)
while (input ~= 'q')
    %Initializes a timer for the maze 
    t = timer('TimerFcn', 'stat=false; disp(''You lost!'')',... 
                 'StartDelay',45);
    start(t)
    stat=true;
    gameStartTime = now;

    while(stat == true)
        title('Maze')
        input = getKeyboardInput(my_scene1);
        %Movement 
        if isequal(input,'rightarrow') && x ~= 21
            if(Collision(rooms_display1, x+1,y,maze_tile) == 1 && Collision(rooms_display1,x+1,y,lock))
                gameboard_display1(y,x) = blank_sprite;
                x = x + 1;
            end 
        elseif isequal(input,'leftarrow') && x ~= 1
            if(Collision(rooms_display1,x-1,y,maze_tile))
                gameboard_display1(y,x) = blank_sprite;
                x = x - 1;
            end
    
        elseif isequal(input,'uparrow') && y ~= 1
            if(Collision(rooms_display1,x,y-1,maze_tile))
                gameboard_display1(y,x) = blank_sprite;
                y = y - 1;            
            end 
    
        elseif isequal(input,'downarrow') && y ~= 21
            if(Collision(rooms_display1,x,y+1,maze_tile))
                gameboard_display1(y,x) = blank_sprite;
                y = y + 1;
            end 
        end
        if y == 18 && x == 8
            rooms_display1(20,21) = floor_tile;
        end 
        if y== 20 && x == 21
    
            input = 'q';
            stat = false;
            mazeComplete = 1; 
            delete(t);
            
        end 
        gameboard_display1(y,x) = player_sprite;
        drawScene(my_scene1,rooms_display1,gameboard_display1)
        currentTime = now;
        elapsedTime = 45 - (floor((currentTime - gameStartTime) * 86400)); % Calculation for how many seconds have passed, takes in the current time in a hour minute second format
        temp1 = num2str(elapsedTime);
        temp2 = ' seconds left';
        stringTime = append(temp1,temp2);
        xlabel(stringTime,"FontSize",15);
        if elapsedTime == 0
            mazeComplete = 0 ;
            stat = false; 
        end 
    end
    delete(t);
    input = 'q';

end
end 

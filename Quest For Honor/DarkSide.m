function [win] = DarkSide(~)
    win = 0 ; %Flag for winning 
    my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);
    life = 5;
    %Creates the sprites for scene
    blank_sprite = 1;
    sword_player_sprite = 28;
    armored_player_sprite = 32;
    king_sprite = 3*32 + 29;
    door_sprite = 9*32+11;
    castle_floor_sprite = 18;
    stairs_down_sprite = 6*32 + 4;
    chest_sprite = 6*32 + 9;
    open_chest_sprite = 6*32 + 10;
    fire_sprite = 10*32 + 16;
    %Creates the room backgrounds
    rooms_display1 = castle_floor_sprite * ones(10,10);
    rooms_display1(3,6) = chest_sprite;
    rooms_display1(10,10) = stairs_down_sprite;
    rooms_display1(10,5) = door_sprite;
    rooms_display1(3,5) = king_sprite;
    y = 3;
    x = 3;
    %Places the sprites for scene
    gameboard_display1 = blank_sprite * ones(10,10);
    gameboard_display1(y,x) = sword_player_sprite;
    dialogue = 0;
    player = 1;
    fire_place = 0; 
    input = 'a';
    moveCount = 0; 
    while (input ~= 'q')
        drawScene(my_scene1,rooms_display1,gameboard_display1)
        title('Inside the Castle')
        if dialogue == 0
            xlabel('King: You returned! ')
            getKeyboardInput(my_scene1);
            xlabel('Leon: Wow you can see!')
            getKeyboardInput(my_scene1);
            xlabel('King: Where is my daughter??')
            getKeyboardInput(my_scene1);
            xlabel('Leon: She is still with Drakkar ')
            getKeyboardInput(my_scene1);
            xlabel('King: How are you here alive??')
            getKeyboardInput(my_scene1);
            xlabel('Leon: My father gave me a task')
            getKeyboardInput(my_scene1);
            xlabel('King: Thats where I know the name from , I should have known.')
            getKeyboardInput(my_scene1);
            xlabel('Leon: It is time for me to defeat you.')
            getKeyboardInput(my_scene1);
            xlabel("King: We shall see.")
            getKeyboardInput(my_scene1);
            xlabel('Leon: You are but an old man , what can you do?')
            getKeyboardInput(my_scene1);
            xlabel('King: The battle is within our souls.')
            dialogue = 1;
        end
        input = getKeyboardInput(my_scene1);
        rooms_display1 = blank_sprite * ones(10,10);
        if dialogue == 1
            xlabel("I want to see you try and dodge this.")
            dialogue = 2; 
        end 
        %Initial positions of fire, the ones indicate where the fire will be placed 
        if fire_place == 0 
            place_fire = [0,0,0,0,1,0,1,0,1,0
                          0,0,1,0,1,0,0,0,0,0
                          0,0,0,0,0,0,0,1,0,0
                          0,0,1,0,1,0,1,0,0,0
                          0,1,0,1,0,1,0,0,0,0
                          1,0,0,0,0,0,0,0,1,0
                          0,0,1,0,0,1,0,0,0,0
                          0,0,0,1,0,0,0,1,0,0
                          1,0,0,1,0,0,1,0,0,0
                          0,0,1,0,0,1,0,0,1,0];
        %nested for loop to iterate through the foreground so that the fire can be placed in the foreground 
            for i = 1:10
                for j = 1:10
                    if place_fire(i,j) == 1
                        gameboard_display1(i,j) = fire_sprite;
                    end 
                end 
            end 
            fire_place = 1;
        end 
        %Movement code
        if isequal(input,'rightarrow') && x ~= 10 
            gameboard_display1(y,x) = blank_sprite;
            if ~Collision(gameboard_display1,x+1,y,fire_sprite)
                life = life - 1;
            end 
            moveCount = moveCount + 1;
            x = x + 1;
        elseif isequal(input,'leftarrow') && x ~= 1 
            gameboard_display1(y,x) = blank_sprite;
            if ~Collision(gameboard_display1,x-1,y,fire_sprite)
                life = life - 1;
            end 
            moveCount = moveCount + 1;
            x = x - 1;
        elseif isequal(input,'uparrow') && y ~= 1 
            gameboard_display1(y,x) = blank_sprite;
            if ~Collision(gameboard_display1,x,y-1,fire_sprite)
                life = life - 1;
            end 
            moveCount = moveCount + 1 ;
            y = y - 1;
        elseif isequal(input,'downarrow') && y ~= 10 
            gameboard_display1(y,x) = blank_sprite;
            if ~Collision(gameboard_display1,x,y+1,fire_sprite)
                life = life - 1;
            end 
            moveCount = moveCount + 1; 
            y = y + 1;
        end
        ylabel(life)
        if player == 1
            gameboard_display1(y,x) = sword_player_sprite;
        elseif player == 2
            gameboard_display1(y,x) = armored_player_sprite;
        end
        %Code to move the fire around as it is the obstacle
        for i = 1:10
            for j = 1:10 
                if gameboard_display1(i,j) == fire_sprite
                    [fireX,fireY] = firePos(i,j);
                    if gameboard_display1(fireX,fireY) ~= fire_sprite && gameboard_display1(fireX,fireY) ~= sword_player_sprite
                        gameboard_display1(i,j) = blank_sprite;
                        gameboard_display1(fireX,fireY) = fire_sprite;
                    end 
                end 
            end 
        end 
        %Tracks movecount and once the required limit is hit the player wins the game
        if moveCount == 50
            input = 'q';
            win = 1;

        end 
        if life == 0
            input = 'q';
            win = 0; 
        end 
    end
end 
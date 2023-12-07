function [lifeout] = castle2(x,y,life)
clc
%Creates the scene
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);

%Creates the sprites for scene
blank_sprite = 1;
armored_player_sprite = 32;
dungeon_floor_sprite = 3;
stairs_up_sprite = 6*32 + 3;
closed_door_sprite = 9*32 + 2;
open_door_sprite = 9*32 + 3;
off_lever_sprite = 10*32 + 4;
on_lever_sprite = 10*32 + 5;
guard_sprite = 30;
campfire_sprite = 10*32 + 15;

%Creates the room backgrounds
rooms_display1 = dungeon_floor_sprite * ones(10,10);
rooms_display1(10,10) = stairs_up_sprite;
rooms_display1(1,5) = closed_door_sprite;
rooms_display1(5,4) = guard_sprite;
rooms_display1(1,10) = off_lever_sprite;
rooms_display1(5,5) = campfire_sprite;


%Places the sprites for scene
gameboard_display1 = blank_sprite * ones(10,10);
gameboard_display1(y,x) = armored_player_sprite;

dialogue = 0; %dialogue Flag
open = 0;%Lever flag 

input = 'a';
while (input ~= 'q')
    drawScene(my_scene1,rooms_display1,gameboard_display1)
    title('Dungeon Entrance')
    ylabel(life)
    if dialogue == 0
        %Dialgoue 
        xlabel('Guard: Hello there, you must''ve been sent by the king.')
        getKeyboardInput(my_scene1);
        xlabel('Leon: I have. Is that the entrance to the dungeon?')
        getKeyboardInput(my_scene1);
        xlabel('Guard: Yes, the dungeon is behind this door.')
        getKeyboardInput(my_scene1);
        xlabel('But it is closed right now.')
        getKeyboardInput(my_scene1);
        xlabel('To open the door, go flip that switch in the corner.')
        getKeyboardInput(my_scene1);
        xlabel('Before, you leave I must tell you something about the first room.')
        getKeyboardInput(my_scene1);
        xlabel('It''s a maze, and whoever enters it, has 45 seconds to complete it.')
        getKeyboardInput(my_scene1);
        xlabel('If you dont make it, then you''ll become like the 206 people before you.')
        getKeyboardInput(my_scene1);
        xlabel('Leon: Thanks for the tip.')
        getKeyboardInput(my_scene1);
        xlabel('Guard: May I ask for your name?')
        getKeyboardInput(my_scene1);
        xlabel('Leon: It''s Leon, you''ll see me back no time with the princess.')
        getKeyboardInput(my_scene1);
        xlabel('Guard: Leon? I''ve heard of that name before...')
        getKeyboardInput(my_scene1);
        xlabel('But where?')
        getKeyboardInput(my_scene1);
        xlabel('Nevermind. I bid you farewell and goodluck.')
        dialogue = 1;
    end

    %Movement code 
    input = getKeyboardInput(my_scene1);
    if isequal(input,'rightarrow') && x ~= 10
        if ~Collision(rooms_display1,x+1,y,campfire_sprite) %Checks if you run into fire to reset health if needed
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            x = x + 1;
        end
    elseif isequal(input,'leftarrow') && x ~= 1
        if ~Collision(rooms_display1,x-1,y,campfire_sprite) %Checks if you run into fire to reset health if needed
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            x = x - 1;
        end
    elseif isequal(input,'uparrow') && y ~= 1
        if ~Collision(rooms_display1,x,y-1,campfire_sprite) %Checks if you run into fire to reset health if needed
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            y = y - 1;
        end
    elseif isequal(input,'downarrow') && y ~= 10
        if ~Collision(rooms_display1,x,y+1,campfire_sprite) %Checks if you run into fire to reset health if needed
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            y = y + 1;
        end
    elseif isequal(input, 'e') && x == 10 && y == 1
        xlabel('You opened the door.')
        rooms_display1(1,10) = blank_sprite;
        rooms_display1(1,5) = blank_sprite;
        rooms_display1(1,10) = on_lever_sprite;
        rooms_display1(1,5) = open_door_sprite;
        open = 1;
    elseif isequal(input, 'e') && x == 5 && y == 1
        xlabel('This leads to the dungeons.')
        if open == 0
            xlabel('I need to flip the switch first.')
        elseif open == 1
        input = 'q';
        lifeout = life;
        end
    end
    if life == 0
        xlabel('You died!')
        lifeout = life;
        input = 'q';
    end
    gameboard_display1(y,x) = armored_player_sprite;
end
end
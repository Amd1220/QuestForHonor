function [lifeout] = house1(x,y,life)
clc
%Creates the scene
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);

%Creates the sprites for scene
blank_sprite = 1;
player_sprite = 27;
sword_player_sprite = 28;
door_sprite = 9*32+11;
empty_room_floor_sprite = 17;
stairs_up_sprite = 6*32 + 3;
stairs_down_sprite = 6*32 + 4;
bookshelf_sprite = 6*32 + 6;
chest_sprite = 6*32 + 9;
open_chest_sprite = 6*32 + 10;
bed_sprite = 8*32 + 6;

%Creates the room backgrounds
rooms_display1 = empty_room_floor_sprite * ones(10,10);
rooms_display1(1,1:9) = bookshelf_sprite;
rooms_display1(5,5) = chest_sprite;
rooms_display1(10,10) = stairs_down_sprite;
rooms_display1(10,1) = stairs_up_sprite;
rooms_display1(1,10) = door_sprite;
rooms_display1(5,1) = bed_sprite;

%Places the sprites for scene
gameboard_display1 = blank_sprite * ones(10,10);
gameboard_display1(y,x) = player_sprite;

dialogue = 0; % Dialgoue Flag 
player = 1;

input = 'a';
while (input ~= 'q')
    drawScene(my_scene1,rooms_display1,gameboard_display1)
    title('Home')
    ylabel(life)
    %Dialogue 
    if dialogue == 0
        xlabel('*Knock knock knock*')
        getKeyboardInput(my_scene1);
        xlabel('???: Open the door!')
        getKeyboardInput(my_scene1);
        xlabel('Leon: I wonder who it is?')
        getKeyboardInput(my_scene1);
        xlabel('I better grab my sword from my chest just in case they''re dangerous.')
        getKeyboardInput(my_scene1);
        xlabel('Move with arrow keys. Interact with ''e''.')
        dialogue = 1;
    end

    input = getKeyboardInput(my_scene1);

    %Movement code 
    if isequal(input,'rightarrow') && x ~= 10 && Collision(rooms_display1,x+1,y,bookshelf_sprite)
        gameboard_display1(y,x) = blank_sprite;
        x = x + 1;
    elseif isequal(input,'leftarrow') && x ~= 1 &&  Collision(rooms_display1,x-1,y,bookshelf_sprite)
        gameboard_display1(y,x) = blank_sprite;
        x = x - 1;
    elseif isequal(input,'uparrow') && y ~= 1 &&  Collision(rooms_display1,x,y-1,bookshelf_sprite)
        gameboard_display1(y,x) = blank_sprite;
        y = y - 1;
    elseif isequal(input,'downarrow') && y ~= 10 &&  Collision(rooms_display1,x,y+1,bookshelf_sprite)
        gameboard_display1(y,x) = blank_sprite;
        y = y + 1;
    elseif isequal(input, 'e') && x == 1 && y == 5
        xlabel('This is my bed')
    elseif isequal(input, 'e') && x == 5 && y == 5 && player == 1
        xlabel('This is my chest, its got a sword.')
        rooms_display1(5,5) = blank_sprite;
        rooms_display1(5,5) = open_chest_sprite;
        player = 2;
    elseif isequal(input, 'e') && x == 1 && y == 10
        xlabel('This leads upstairs')
    elseif isequal(input, 'e') && x == 10 && y == 10
        xlabel('This leads downstairs')
    elseif isequal(input, 'e') && x == 10 && y == 1
        if player == 1
            xlabel('I need to get my sword first.')
        elseif player == 2
        xlabel('This is the exit.')
        input = 'q';
        lifeout = life;
        end
    end
    %Sets player sprite so he has a sword equipped
    if player == 1
        gameboard_display1(y,x) = player_sprite;
    elseif player == 2
        gameboard_display1(y,x) = sword_player_sprite;
    end
end
end
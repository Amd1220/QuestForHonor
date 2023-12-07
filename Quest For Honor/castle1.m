function [lifeout] = castle1(x,y,life)
clc
%Creates the scene
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);

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

%Creates the room backgrounds
rooms_display1 = castle_floor_sprite * ones(10,10);
rooms_display1(3,6) = chest_sprite;
rooms_display1(10,10) = stairs_down_sprite;
rooms_display1(10,5) = door_sprite;
rooms_display1(3,5) = king_sprite;


%Places the sprites for scene
gameboard_display1 = blank_sprite * ones(10,10);
gameboard_display1(y,x) = sword_player_sprite;

dialogue = 0;% dialogue Flag
player = 1; % Assigns sprite for player 

input = 'a';
while (input ~= 'q')
    drawScene(my_scene1,rooms_display1,gameboard_display1)
    title('Inside the Castle')
    ylabel(life)
    %dialogue
    if dialogue == 0
        xlabel('King: Who might you be, young man?')
        getKeyboardInput(my_scene1);
        xlabel('Leon: My name is Leon, I''ve come to save the princess.')
        getKeyboardInput(my_scene1);
        xlabel('King: Hmm... Leon you say?')
        getKeyboardInput(my_scene1);
        xlabel('*Whispers* Now where have I heard that name before?')
        getKeyboardInput(my_scene1);
        xlabel('Well Leon, you seem very brave for boy like you.')
        getKeyboardInput(my_scene1);
        xlabel('I can asure you, this will be no easy task.')
        getKeyboardInput(my_scene1);
        xlabel('Hundreds of other men have attemped to rescue my daughter.')
        getKeyboardInput(my_scene1);
        xlabel('But not a single one has returned from the dungeons.')
        getKeyboardInput(my_scene1);
        xlabel('What brings you to the challenge?')
        getKeyboardInput(my_scene1);
        xlabel('Leon: Honor, your majesty. Ive come to seek honor in Matland.')
        getKeyboardInput(my_scene1);
        xlabel('King: Daring today are we?')
        getKeyboardInput(my_scene1);
        xlabel('You passed the vibe check.')
        getKeyboardInput(my_scene1);
        xlabel('To help you on your journey, I''ll bestow you the royal guard''s armor.')
        getKeyboardInput(my_scene1);
        xlabel('I have contained its pieces within this chest. ')
        getKeyboardInput(my_scene1);
        xlabel("It is the 37th piece of armor I have! That's my favorite number.")
        xlabel('Then make your way down those stairs. It''s a shortcut to the dungeon.')
        getKeyboardInput(my_scene1);
        xlabel('Save my daughter and the honor you seek shall be yours.')
        dialogue = 1;
    end

    %Movement code 
    input = getKeyboardInput(my_scene1);
    if isequal(input,'rightarrow') && x ~= 10
        gameboard_display1(y,x) = blank_sprite;
        x = x + 1;
    elseif isequal(input,'leftarrow') && x ~= 1
        gameboard_display1(y,x) = blank_sprite;
        x = x - 1;
    elseif isequal(input,'uparrow') && y ~= 1
        gameboard_display1(y,x) = blank_sprite;
        y = y - 1;
    elseif isequal(input,'downarrow') && y ~= 10
        gameboard_display1(y,x) = blank_sprite;
        y = y + 1;
    elseif isequal(input, 'e') && x == 6 && y == 3 && player == 1
        xlabel('You got the royal armor!')
        rooms_display1(3,6) = blank_sprite;
        rooms_display1(3,6) = open_chest_sprite;
        player = 2;
    elseif isequal(input, 'e') && x == 10 && y == 10
        xlabel('This leads to the dungeons.')
        if player == 1
            xlabel('I need to get my armor first.')
        elseif player == 2
        input = 'q';
        lifeout = life;
        end
    end
    %Sets the player sprite once armor is equipped 
    if player == 1
        gameboard_display1(y,x) = sword_player_sprite;
    elseif player == 2
        gameboard_display1(y,x) = armored_player_sprite;
    end
end
end
function [lifeout] = outside2(x,y,life)
clc
%Creates the scenes
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[45,121,55]);

%Creates the sprites for scene
blank_sprite = 1;
grass_sprite = 6;
sword_player_sprite = 28;
tree_sprite = 1*32 + 1;
castle_sprite = 19*32 + 7;
enemy_sprite = 7*32 + 19;

%Creates the room backgrounds
rooms_display1 = grass_sprite * ones(10,10);
rooms_display1(1,1:10) = tree_sprite;
rooms_display1(1:10,1) = tree_sprite;
rooms_display1(10,1:10) = tree_sprite;
rooms_display1(4,5) = tree_sprite;
rooms_display1(4,4) = tree_sprite;
rooms_display1(4,6) = tree_sprite;
rooms_display1(5,6) = tree_sprite;
rooms_display1(5,4) = tree_sprite;
rooms_display1(5,5) = castle_sprite;
rooms_display1(6,5) = enemy_sprite;
rooms_display1(2,2) = enemy_sprite;
rooms_display1(3,8) = enemy_sprite;
rooms_display1(8,7) = enemy_sprite;

%Places the sprites for scene
gameboard_display1 = blank_sprite * ones(10,10);
gameboard_display1(y,x) = sword_player_sprite;

dialogue = 0;
input = 'a';
while (input ~= 'q')
    drawScene(my_scene1,rooms_display1,gameboard_display1)
    title('Outside the Castle')
    ylabel(life)
    if dialogue == 0
        xlabel('Leon: There''s the castle!')
        dialogue = 1;
    end
    input = getKeyboardInput(my_scene1);
    %Movement code, removes life if you run into enemies 
    if isequal(input,'rightarrow') && x ~= 10 && Collision(rooms_display1,x+1,y,tree_sprite)
        if ~Collision(rooms_display1,x+1,y,enemy_sprite)
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            x = x + 1;
        end
    elseif isequal(input,'leftarrow') && x ~= 1 && Collision(rooms_display1,x-1,y,tree_sprite)
        if ~Collision(rooms_display1,x-1,y,enemy_sprite)
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            x = x - 1;
        end
    elseif isequal(input,'uparrow') && y ~= 1 && Collision(rooms_display1,x,y-1,tree_sprite)
        if ~Collision(rooms_display1,x,y-1,enemy_sprite)
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            y = y - 1;
        end
    elseif isequal(input,'downarrow') && y ~= 10 && Collision(rooms_display1,x,y+1,tree_sprite)
        if ~Collision(rooms_display1,x,y+1,enemy_sprite)
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            y = y + 1;
        end
    %Killing function for enemies 
    elseif isequal(input,'e') && ~Collision(rooms_display1,x+1,y,enemy_sprite)
        rooms_display1(y,x+1) = blank_sprite;
        rooms_display1(y,x+1) = grass_sprite;
    elseif isequal(input,'e') && ~Collision(rooms_display1,x-1,y,enemy_sprite)
        rooms_display1(y,x-1) = blank_sprite;
        rooms_display1(y,x-1) = grass_sprite;
    elseif isequal(input,'e') && ~Collision(rooms_display1,x,y-1,enemy_sprite)
        rooms_display1(y-1,x) = blank_sprite;
        rooms_display1(y-1,x) = grass_sprite;
    elseif isequal(input,'e') && ~Collision(rooms_display1,x,y+1,enemy_sprite)
        rooms_display1(y+1,x) = blank_sprite;
        rooms_display1(y+1,x) = grass_sprite;
    elseif isequal(input,'e') && x == 5 && y == 5
        input = 'q';
        lifeout = life;
    end

    if life == 0
        xlabel('You died!')
        lifeout = life;
        input = 'q';
    end
    gameboard_display1(y,x) = sword_player_sprite;
end
end
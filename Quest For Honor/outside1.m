function [yout, lifeout] = outside1(x, y, life)
clc
%Creates the scenes
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[45,121,55]);

%Creates the sprites for scene
blank_sprite = 1;
grass_sprite = 6;
sword_player_sprite = 28;
wizard_sprite = 2*32 + 25;
tree_sprite = 1*32 + 1;
river_sprite = 4*32 + 9;
bridge_sprite = 5*32 + 7;
house_sprite = 19*32 + 2;
enemy_sprite = 7*32 + 19;

%Creates the room backgrounds
rooms_display1 = grass_sprite * ones(10,10);
rooms_display1(1,1:10) = tree_sprite;
rooms_display1(1:10,10) = tree_sprite;
rooms_display1(10,1:10) = tree_sprite;
rooms_display1(3,2) = tree_sprite;
rooms_display1(6,1) = tree_sprite;
rooms_display1(3,2) = tree_sprite;
rooms_display1(3,8) = tree_sprite;
rooms_display1(7,6) = tree_sprite;
rooms_display1(1:4,5) = river_sprite;
rooms_display1(6:10,5) = river_sprite;
rooms_display1(5,5) = bridge_sprite;
rooms_display1(9,7) = wizard_sprite;
rooms_display1(9,9) = house_sprite;
rooms_display1(7,2) = enemy_sprite;
rooms_display1(5,4) = enemy_sprite;

%Places the sprites for scene
gameboard_display1 = blank_sprite * ones(10,10);
gameboard_display1(y,x) = sword_player_sprite;


dialogue = 0;

input = 'a';
drawScene(my_scene1,rooms_display1,gameboard_display1)
while (input ~= 'q')
    title('Outside')
    ylabel(life)
    if dialogue == 0
        xlabel('Leon: Who are you?')
        getKeyboardInput(my_scene1);
        xlabel('Messenger: I am the king''s messenger.')
        getKeyboardInput(my_scene1);
        xlabel('I am here to deliver horrible news.')
        getKeyboardInput(my_scene1);
        xlabel('The evil king Drakkon has kidnapped the princess!')
        getKeyboardInput(my_scene1);
        xlabel('Will you be willing to save her?')
        getKeyboardInput(my_scene1);
        xlabel('Your name will be rewarded with infinite riches if you save her.')
        getKeyboardInput(my_scene1);
        xlabel('Leon: Sounds like a deal to me.')
        getKeyboardInput(my_scene1);
        xlabel('Messenger: Great! Go to the castle immediatly!')
        getKeyboardInput(my_scene1);
        xlabel('The king will give you further instructions.')
        dialogue = 1;
    end
    input = getKeyboardInput(my_scene1);
    %Code for the movement , checks for collission with the enemy to remove life points. 
    if isequal(input,'rightarrow') && x ~= 10 && Collision(rooms_display1,x+1,y,tree_sprite) && Collision(rooms_display1,x+1,y,river_sprite)
        if ~Collision(rooms_display1,x+1,y,enemy_sprite)
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            x = x + 1;
        end
    elseif isequal(input,'leftarrow') && x ~= 1 && Collision(rooms_display1,x-1,y,tree_sprite) && Collision(rooms_display1,x-1,y,river_sprite)
        if ~Collision(rooms_display1,x-1,y,enemy_sprite)
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            x = x - 1;
        end
    elseif isequal(input,'uparrow') && y ~= 1 && Collision(rooms_display1,x,y-1,tree_sprite) && Collision(rooms_display1,x,y-1,river_sprite)
        if ~Collision(rooms_display1,x,y-1,enemy_sprite)
            life = life - 1;
            xlabel('Ouch!')
        else
            gameboard_display1(y,x) = blank_sprite;
            y = y - 1;
        end
    elseif isequal(input,'downarrow') && y ~= 10 && Collision(rooms_display1,x,y+1,tree_sprite) && Collision(rooms_display1,x,y+1,river_sprite)
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
    end

    if x == 1
        input = 'q';
        yout = y;
        lifeout = life;
    elseif life == 0
        xlabel('You died!')
        lifeout = life;
        yout = y;
        input = 'q';
    end
    gameboard_display1(y,x) = sword_player_sprite;
    drawScene(my_scene1,rooms_display1,gameboard_display1)
end
end
function [choice] = replay()
clc
%Creates the scene
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);

%Creates the sprites for scene
blank_sprite = 1;
p_sprite = 31*32 + 22;
l_sprite = 30*32 + 31;
a_sprite = 30*32 + 20;
y_sprite = 31*32 + 31;
g_sprite = 30*32 + 26;
i_sprite = 30*32 + 28;
n_sprite = 31*32 + 20;
question_sprite = 25*32 + 22;

%Creates the room backgrounds
rooms_display1 = blank_sprite * ones(1,11);
rooms_display1(1,1) = p_sprite;
rooms_display1(1,2) = l_sprite;
rooms_display1(1,3) = a_sprite;
rooms_display1(1,4) = y_sprite;
rooms_display1(1,5) = blank_sprite;
rooms_display1(1,6) = a_sprite;
rooms_display1(1,7) = g_sprite;
rooms_display1(1,8) = a_sprite;
rooms_display1(1,9) = i_sprite;
rooms_display1(1,10) = n_sprite;
rooms_display1(1,11) = question_sprite;

%Places the sprites for scene
gameboard_display1 = blank_sprite * ones(1,11);


drawScene(my_scene1,rooms_display1,gameboard_display1)
%Asks the user if they want to play again, if the input is y then the code runs again, other wise it breaks 
xlabel('y for yes or n for no')
input = 'a';
while input ~= 'q'
    input = getKeyboardInput(my_scene1);
    if isequal(input,'y')
        choice = 1;
        break
    elseif isequal(input,'n')
        choice = 0;
        break
    end
end
end
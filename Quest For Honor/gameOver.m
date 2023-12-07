function [] = gameOver()
clc
%Displays game over when you die 
%Creates the scene
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);

%Creates the sprites for scene
blank_sprite = 1;
g_sprite = 30*32 + 26;
a_sprite = 30*32 + 20;
m_sprite = 31*32;
e_sprite = 30*32 + 24;
o_sprite = 31*32 + 21;
v_sprite = 31*32 + 28;
r_sprite = 31*32 + 24;
question_sprite = 25*32 + 20;


%Creates the room backgrounds
rooms_display1 = blank_sprite * ones(1,10);
rooms_display1(1,1) = g_sprite;
rooms_display1(1,2) = a_sprite;
rooms_display1(1,3) = m_sprite;
rooms_display1(1,4) = e_sprite;
rooms_display1(1,5) = blank_sprite;
rooms_display1(1,6) = o_sprite;
rooms_display1(1,7) = v_sprite;
rooms_display1(1,8) = e_sprite;
rooms_display1(1,9) = r_sprite;
rooms_display1(1,10) = question_sprite;

%Places the sprites for scene
gameboard_display1 = blank_sprite * ones(1,10);

drawScene(my_scene1,rooms_display1,gameboard_display1)
getKeyboardInput(my_scene1);

end
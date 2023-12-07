function [] = titleScreen()
clc
%Displays simple title screen for the game. 
%Creates the scene
my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[35,64,153]);

%Creates the sprites for scene
blank_sprite = 1;
t_sprite = 31*32 + 26;
h_sprite = 30*32 + 27;
e_sprite = 30*32 + 24;
q_sprite = 31*32 + 23;
u_sprite = 31*32 + 27;
s_sprite = 31*32 + 25;
f_sprite = 30*32 +25;
o_sprite = 31*32 + 21;
r_sprite = 31*32 + 24;
n_sprite = 31*32 + 20;


%Creates the room backgrounds
rooms_display1 = blank_sprite * ones(2,9);
rooms_display1(1,1) = t_sprite;
rooms_display1(1,2) = h_sprite;
rooms_display1(1,3) = e_sprite;
rooms_display1(1,4) = blank_sprite;
rooms_display1(1,5) = q_sprite;
rooms_display1(1,6) = u_sprite;
rooms_display1(1,7) = e_sprite;
rooms_display1(1,8) = s_sprite;
rooms_display1(1,9) = t_sprite;
rooms_display1(2,1) = f_sprite;
rooms_display1(2,2) = o_sprite;
rooms_display1(2,3) = r_sprite;
rooms_display1(2,4) = blank_sprite;
rooms_display1(2,5) = h_sprite;
rooms_display1(2,6) = o_sprite;
rooms_display1(2,7) = n_sprite;
rooms_display1(2,8) = o_sprite;
rooms_display1(2,9) = r_sprite;

%Places the sprites for scene
gameboard_display1 = blank_sprite * ones(2,9);

drawScene(my_scene1,rooms_display1,gameboard_display1)
xlabel('press anything to continue');
getKeyboardInput(my_scene1);
end
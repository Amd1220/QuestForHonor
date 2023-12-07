function [DarkSide] = BossRoom(~)
    DarkSide = 0;
    my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);
    
    %Creates the sprites for scene
    blank_sprite = 1;
    player_sprite = 27;
    sword_player_sprite = 32;
    door_sprite = 9*32+11;
    empty_room_floor_sprite = 17;
    stairs_up_sprite = 6*32 + 3;
    stairs_down_sprite = 6*32 + 4;
    bookshelf_sprite = 6*32 + 6;
    chest_sprite = 6*32 + 9;
    open_chest_sprite = 6*32 + 10;
    bed_sprite = 8*32 + 6;
    boss_sprite = 7* 32 + 25;
    x = 3;
    y = 7;
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
    gameboard_display1(y,x) = sword_player_sprite;
    gameboard_display1(y,x +2) = boss_sprite;
    drawScene(my_scene1,rooms_display1,gameboard_display1)
    decision = '';
    dialogue = 1; %Flag for dialogue 
    %Dialogue 
    while dialogue == 1
        xlabel('Drakkar: Hello There')
        getKeyboardInput(my_scene1);
        xlabel('Leon: Where is the princess??')
        getKeyboardInput(my_scene1);
        xlabel('Drakkar: You are a fiesty one.')
        getKeyboardInput(my_scene1);
        xlabel('Boss: Just like me... those eyes....')
        getKeyboardInput(my_scene1);
        xlabel('Drakkar: Will you just shut up and fight me now?!')
        getKeyboardInput(my_scene1);
        xlabel('Boss: Calm down son.')
        getKeyboardInput(my_scene1);
        xlabel('Drakkar: I am here to save the princess and get the highest honor in the land.')
        getKeyboardInput(my_scene1);
        xlabel('Leon: Wait, son?!')
        getKeyboardInput(my_scene1);
        xlabel('Drakkar: Yes Leon, I AM YOUR FATHER!')
        getKeyboardInput(my_scene1);
        xlabel('Leon: You have been gone since I was born :( ')
        getKeyboardInput(my_scene1);
        xlabel('Leon: Why did you do that to me?')
        getKeyboardInput(my_scene1);
        xlabel("Drakkar: I am sorry for that son, but let me make it up to you.")
        getKeyboardInput(my_scene1);
        xlabel("Leon: How will you do that?")
        getKeyboardInput(my_scene1);
        xlabel("Drakkar: Join me my son, we shall take over the world together!")
        getKeyboardInput(my_scene1);
        xlabel("Drakkar: I just need you to defeat the king in battle.")
        getKeyboardInput(my_scene1);
        xlabel("Hit y to join your father, hit n to fight him.")
        decision = getKeyboardInput(my_scene1); %Gets decision to see how the game will progress 
        if(isequal(decision,'y'))
            xlabel("Leon: Alright dad, lets do this!")
            DarkSide = 1;
        else
            xlabel("Leon: Heck no, I will be the one to take you down.")
            DarkSide = 0;
            getKeyboardInput("Drakkar: Let our minds do battle then.")
        end 
        dialogue = 0;
    end 
    
end 
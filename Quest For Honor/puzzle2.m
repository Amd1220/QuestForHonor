function[LeversComplete] = puzzle2(~)
    LeversComplete = 0; 
    my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);
    x = 1;
    y = 1;
    %Creates the sprites for scene
    blank_sprite = 1;
    armored_player_sprite = 32;
    dungeon_floor_sprite = 3;
    closed_door_sprite = 9*32 + 2;
    open_door_sprite = 9*32 + 3;
    off_lever_sprite = 10*32 + 4;
    on_lever_sprite = 10*32 + 5;
    bookshelf_sprite = 6*32 + 6;

    
    %Creates the room backgrounds
    rooms_display1 = dungeon_floor_sprite * ones(12,12);
    rooms_display1(12,5) = on_lever_sprite;
    rooms_display1(12,6) = on_lever_sprite;
    rooms_display1(12,7) = on_lever_sprite;
    rooms_display1(12,8) = on_lever_sprite;
    rooms_display1(1,5) = bookshelf_sprite;
    rooms_display1(1,6) = bookshelf_sprite;
    rooms_display1(1,7) = bookshelf_sprite;
    rooms_display1(1,8) = bookshelf_sprite;
    rooms_display1(6,12) = closed_door_sprite;
    %Places the sprites for scene
    gameboard_display1 = blank_sprite * ones(12,12);
    gameboard_display1(y,x) = armored_player_sprite;
    
    dialogue = 1;
    switchCounter = 0; 
    input = 'a';
    while (input ~= 'q')
        drawScene(my_scene1,rooms_display1,gameboard_display1)
        
        while dialogue == 1
            xlabel('Use the questions around the room to find out which levers need to be flipped.')
            getKeyboardInput(my_scene1);
            xlabel('Right means yes, and left means no')
            getKeyboardInput(my_scene1);
            xlabel('If you do not get it right within 15 lever switches this dungeon will collapse around you.')
            getKeyboardInput(my_scene1);
            xlabel('The bookshelves opposite the levers will give you the question for their respective levers.')
            getKeyboardInput(my_scene1);
            xlabel('That door you see to your right will unlock when the correct levers are flipped.')
            getKeyboardInput(my_scene1);
            xlabel('That is the entry way to the boss , I hope you are prepared for whatever comes next.')
            getKeyboardInput(my_scene1);

            dialogue = 0;
        end
        title('Levers')
        input = getKeyboardInput(my_scene1);
        %Movement, checks to make sure you do not run into book sheleves or levers 
        if isequal(input,'rightarrow') && x ~= 12 && Collision(rooms_display1,x+1,y,on_lever_sprite) && Collision(rooms_display1,x+1,y,off_lever_sprite) && Collision(rooms_display1,x+1,y,bookshelf_sprite)
                gameboard_display1(y,x) = blank_sprite;
                
                x = x + 1;
                gameboard_display1(y,x) = armored_player_sprite;

        elseif isequal(input,'leftarrow') && x ~= 1 && Collision(rooms_display1,x-1,y,on_lever_sprite) && Collision(rooms_display1,x-1,y,off_lever_sprite) && Collision(rooms_display1,x-1,y,bookshelf_sprite)
                gameboard_display1(y,x) = blank_sprite;
                x = x - 1;
                gameboard_display1(y,x) = armored_player_sprite;
        elseif isequal(input,'uparrow') && y ~= 1 && Collision(rooms_display1,x,y-1,on_lever_sprite) && Collision(rooms_display1,x,y-1,off_lever_sprite) && Collision(rooms_display1,x,y-1,bookshelf_sprite)
                gameboard_display1(y,x) = blank_sprite;
                y = y - 1;
                gameboard_display1(y,x) = armored_player_sprite;

        elseif isequal(input,'downarrow') && y ~= 12 && Collision(rooms_display1,x,y+1,on_lever_sprite) && Collision(rooms_display1,x,y+1,off_lever_sprite) && Collision(rooms_display1,x,y+1,bookshelf_sprite)
                gameboard_display1(y,x) = blank_sprite;
                y = y + 1;
                gameboard_display1(y,x) = armored_player_sprite;
       %Code to flip the levers on and off, repeated 4 times for each individual lever, all code is the same 
        elseif isequal(input,'e') && x == 5 && y == 11
                if rooms_display1(12,5) == on_lever_sprite
                    rooms_display1(12,5) = off_lever_sprite;
                else
                    rooms_display1(12,5) = on_lever_sprite;
                end 
                %Correct position of levers checker, if true then the door to the next section opens 
                if rooms_display1(12,6) == off_lever_sprite && rooms_display1(12,8) == off_lever_sprite && rooms_display1(12,5) == on_lever_sprite && rooms_display1(12,7)==on_lever_sprite
                    if rooms_display1(6,12) == closed_door_sprite
                        rooms_display1(6,12) = open_door_sprite;
                    else 
                        rooms_display1(6,12) = closed_door_sprite;
                    end 
                else 
                    rooms_display1(6,12) = closed_door_sprite;
                end 
                switchCounter = switchCounter + 1;
                temp1 = num2str(15-switchCounter);
                temp2 = ' switches left';
                text = append(temp1,temp2);
                xlabel(text)
        elseif isequal(input,'e') && x == 6 && y == 11
                if rooms_display1(12,6) == on_lever_sprite
                    rooms_display1(12,6) = off_lever_sprite;
                else
                    rooms_display1(12,6) = on_lever_sprite;
                end        
                if rooms_display1(12,6) == off_lever_sprite && rooms_display1(12,8) == off_lever_sprite && rooms_display1(12,5) == on_lever_sprite && rooms_display1(12,7)==on_lever_sprite
                    if rooms_display1(6,12) == closed_door_sprite
                        rooms_display1(6,12) = open_door_sprite;
                    else 
                        rooms_display1(6,12) = closed_door_sprite;
                    end 
                else 
                    rooms_display1(6,12) = closed_door_sprite;
                end 
                switchCounter = switchCounter + 1; 
                temp1 = num2str(15-switchCounter);
                temp2 = ' switches left';
                text = append(temp1,temp2);
                xlabel(text)
        elseif isequal(input,'e') && x == 7 && y == 11
                if rooms_display1(12,7) == on_lever_sprite
                    rooms_display1(12,7) = off_lever_sprite;
                else
                    rooms_display1(12,7) = on_lever_sprite;
                end 
                if rooms_display1(12,6) == off_lever_sprite && rooms_display1(12,8) == off_lever_sprite && rooms_display1(12,5) == on_lever_sprite && rooms_display1(12,7)==on_lever_sprite
                    if rooms_display1(6,12) == closed_door_sprite
                        rooms_display1(6,12) = open_door_sprite;
                    else 
                        rooms_display1(6,12) = closed_door_sprite;
                    end 
                else 
                    rooms_display1(6,12) = closed_door_sprite;
                end 
                switchCounter = switchCounter + 1; 
                temp1 = num2str(15-switchCounter);
                temp2 = ' switches left';
                text = append(temp1,temp2);
                xlabel(text)
        elseif isequal(input,'e') && x == 8 && y == 11
                if rooms_display1(12,8) == on_lever_sprite
                    rooms_display1(12,8) = off_lever_sprite;
                else
                    rooms_display1(12,8) = on_lever_sprite;
                end 
                if rooms_display1(12,6) == off_lever_sprite && rooms_display1(12,8) == off_lever_sprite && rooms_display1(12,5) == on_lever_sprite && rooms_display1(12,7)==on_lever_sprite
                    if rooms_display1(6,12) == closed_door_sprite
                        rooms_display1(6,12) = open_door_sprite;
                    else 
                        rooms_display1(6,12) = closed_door_sprite;
                    end 
                else 
                    rooms_display1(6,12) = closed_door_sprite;
                end 
                switchCounter = switchCounter +1 ;
                temp1 = num2str(15-switchCounter);
                temp2 = ' switches left';
                text = append(temp1,temp2);
                xlabel(text)
        elseif isequal(input,'e') && x == 5 && y == 2
            xlabel('There are 192 countries in the world.')
        elseif isequal(input,'e') && x == 6 && y == 2
            xlabel('The kings favorite number is 37.')
        elseif isequal(input,'e') && x == 7 && y == 2
            xlabel('Neptune is the only planet that spins clockwise')
        elseif isequal(input,'e') && x == 8 && y == 2
            xlabel('The Eiffel Towers height changes from time to time.')

        end 

        if x == 12 && y == 6 && rooms_display1(6,12) == open_door_sprite
            gameboard_display1(y,x) = armored_player_sprite;
            drawScene(my_scene1,rooms_display1,gameboard_display1)

            LeversComplete = 1;
            input = 'q';
        end 
        if switchCounter > 15 %Checks the switches, if exceeds then game is lost 
            xlabel('Maybe you should have read up on the books in your house.')
            input = 'q';
        end 
    end
end 
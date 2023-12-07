function [lifeout] = miniboss(lifein)
clc


my_scene1 = simpleGameEngine('retro_pack.png',16,16,4,[0,0,0]);
player_sprite = 28;
blank_sprite = 1;
floor_tile = 18*32 +13;
miniboss_sprite = 6 * 32 +31; 
bat_sprite = 8 * 32 + 27;
life = lifein;
gameboard_display1 = blank_sprite * ones(11,11);
rooms_display1 = blank_sprite* ones(11,11);

%Places the enemy bats down 
gameboard_display1(1,1) = player_sprite;
gameboard_display1(6,6) = miniboss_sprite;
gameboard_display1(7,7) = bat_sprite;
gameboard_display1(5,5) = bat_sprite;
gameboard_display1(5,7) = bat_sprite;
gameboard_display1(7,5) = bat_sprite;
gameboard_display1(6,7) = bat_sprite;
gameboard_display1(6,5) = bat_sprite;
gameboard_display1(7,6) = bat_sprite;
gameboard_display1(9,2) = bat_sprite;
gameboard_display1(11,10) = bat_sprite;
gameboard_display1(8,3) = bat_sprite;
gameboard_display1(5,6) = bat_sprite;
gameboard_display1(9,3) = bat_sprite;
gameboard_display1(10,5) = bat_sprite;
gameboard_display1(7,9) = bat_sprite;
gameboard_display1(8,10) = bat_sprite;
gameboard_display1(1,3) = bat_sprite;
gameboard_display1(2,4) = bat_sprite;


drawScene(my_scene1,rooms_display1,gameboard_display1)
dialogue = 0;

input = 'a';
x = 1;
y = 1; 
batX = 0;
batY = 0;
bossHealth = 20; 
batCount = 0;

while (life > 0 && input ~= 'q')
    t2 = timer('TimerFcn', 'stat=false; ',... 
                 'StartDelay',60);
    start(t2)
    %Timer for beating the boss
    stat=true;
    gameStartTime = now;
    while stat == true
        drawScene(my_scene1,rooms_display1,gameboard_display1)
        title('Miniboss Fight!!!')

        titlepart1 = 'Health: ';
        titlepart2 = num2str(life);
        titlepart3 = ' Boss Health: ';
        titlepart4 = num2str(bossHealth);
        titleTotal = append(titlepart1,titlepart2,titlepart3,titlepart4);
        title(titleTotal,FontSize=15);
 

        if dialogue == 0
            xlabel('Who dares to challenge me?')
            getKeyboardInput(my_scene1);
            xlabel('Leon is it? Prepare to meet your doom.')
            getKeyboardInput(my_scene1);
            xlabel('No challenger has been able to kill me.')
            getKeyboardInput(my_scene1);
            xlabel('FEAR MY BATS')
            dialogue = 1;
        end
        input = getKeyboardInput(my_scene1);
        %Movement, if you run into a bat life is lost with the collision code 
        if isequal(input,'rightarrow') && x ~= 11 && Collision(gameboard_display1,x+1,y,miniboss_sprite) 
            gameboard_display1(y,x) = blank_sprite;
            if ~Collision(gameboard_display1,x+1,y,bat_sprite)
                life = life - 1;
            end 

            x = x + 1;
        elseif isequal(input,'leftarrow') && x ~= 1 && Collision(gameboard_display1,x-1,y,miniboss_sprite) 
            gameboard_display1(y,x) = blank_sprite;
            if ~Collision(gameboard_display1,x-1,y,bat_sprite)
                life = life - 1;
            end 
            x = x - 1;
        elseif isequal(input,'uparrow') && y ~= 1 && Collision(gameboard_display1, x,y-1,miniboss_sprite)
            gameboard_display1(y,x) = blank_sprite;
            if ~Collision(gameboard_display1,x,y-1,bat_sprite)
                life = life - 1;
            end 
            y = y - 1;
        elseif isequal(input,'downarrow') && y ~= 11 && Collision(gameboard_display1,x,y+1,miniboss_sprite)
            gameboard_display1(y,x) = blank_sprite;
            if ~Collision(gameboard_display1,x,y+1,bat_sprite)
                life = life - 1;
            end 
            y = y + 1;

        elseif isequal(input,'e')
            if abs(6-x) <= 1 && abs(6-y) <= 1 
                bossHealth = bossHealth - 5;
                input = '';
            end 
        elseif isequal(input,'q')
            stat = false; 
        end 
        %Moves the bats using the batPos code 
        for i = 1:11
            for j = 1:11 
                if gameboard_display1(i,j) == bat_sprite
                    [batX,batY] = batPos(i,j);
                    if gameboard_display1(batX,batY) ~= bat_sprite && gameboard_display1(batX,batY) ~= miniboss_sprite
                        gameboard_display1(i,j) = blank_sprite;
                        gameboard_display1(batX,batY) = bat_sprite;
                    end 
                end 
            end 
        end 
        gameboard_display1(y,x) = player_sprite; 
        if bossHealth == 0
            title("YOU WIN!!!!!")
            input = 'q';
            stat = false;
            lifeout = life;
        end 
        
        if life == 0 
            stat = false;
            title('You Died!')

        end 
        if stat == false
            life = 0 ;
        end 
        currentTime = now;
        elapsedTime = 60 -(floor((currentTime - gameStartTime) * 86400)); % Same timer functionality as seen in maze function 
        temp1 = num2str(elapsedTime);
        temp2 = ' seconds left';
        stringTime = append(temp1,temp2);
        xlabel(stringTime,"FontSize",15);

        
    end 
    lifeout = life;
end
fprintf("Testing")
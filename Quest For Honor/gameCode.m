playAgain = 1;
%Main game loop 
while playAgain == 1
    while playAgain == 1
        warning('off','all');
        clear
        clc
        titleScreen()
        life = 5;
        y = 6;
        x = 1;

        %No real code happens here, just executes all of the functions made as each individual room is a function.
        house1(x,y,life)
        y = 9;
        x = 8;
        [y, life] = outside1(x,y,life);
        if life == 0
            break
        end
        x = 10;
        life = outside2(x,y,life);
        if life == 0
            break
        end
        x = 5;
        y = 9;
        life = castle1(x,y,life);
        x = 9;
        y = 10;
        life = castle2(x,y,life);
        if life == 0
            break
        end
        playAgain = 0;
        mazeComplete = maze();
        fprintf("%i",mazeComplete);
        if mazeComplete == 0
            life = 0 ;
        end 
        life = miniboss(life);
        dungeonComplete = puzzle2();
        if dungeonComplete == 1
            DarkSide = BossRoom();
            
        end 
        win = LightSide();
        if win == 0
            gameOver()
        end 
    end
    
   

    playAgain = replay();
end
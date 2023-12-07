function [value] = Collision(roomDisplay,x,y,collisionTile)
%checks if movement input is valid, the sprites coordinates are passed in, including the tile they are not supposed to hit. Varies from room to room 
%Is called in almost all files to make sure weird clips into walls do not happen. 
if (roomDisplay(y,x) == (collisionTile))
    value = 0;
else 
    value = 1;
end 
end
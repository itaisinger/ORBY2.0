///@description 
hsp = 0;
vsp = 0;
grav = 1
grav_amp = 1;

ground_fric = 1;
air_fric = 0.2;
ground = 0;

killer = noone;
spd = 4;
placed = false; //whether this anvil is placed on the large anvil
creation_num = room; 

//this adds a limit: only 1 anvil pickup per room.
//when taking an anvil, you save its num. when entering a room, if your anvil matches
//another anvil's index, it is destroyed.
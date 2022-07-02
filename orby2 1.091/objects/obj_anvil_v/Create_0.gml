///@description 
event_inherited();
grav = 0.2;
vsp = 0;
play_clang = 1;

is_made = 0;
anchor = false;
weight = WEIGHTS.anvil;
yforce = 0;

var wall = instance_place(x,y-1,obj_pre_solid);
if(wall != noone)
	grav *= -1;

depth = DEPTH.wall;
///@description 
event_inherited();
grav = 0.2;
hsp = 0;
play_clang = 0;

depth = DEPTH.wall;
is_made = 0;
anchor = false;
weight = WEIGHTS.anvil;
xforce = 0;

var wall = instance_place(x-sign(grav),y,obj_pre_solid);
if(wall != noone)
	grav *= -1;
my_wall = instance_place(x,y,obj_solid);
if(my_wall == noone)
	my_wall = instance_place(x,y,obj_wall_fake);
depth = DEPTH.wall-1;

bottom = 1; //this equals the opposite of whats logical.

if(room == rm_pit_top or room == rm_pit_middle)
{
	instance_create_depth(x,y,depth,obj_wall_shadow_pit);
	instance_destroy();
}
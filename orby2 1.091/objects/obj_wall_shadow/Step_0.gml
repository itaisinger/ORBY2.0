if(my_wall == -1)
{
	exit;
}

if(my_wall == noone or !instance_exists(my_wall))
{
	instance_destroy();
	exit;
}
if(my_wall.state == WALL_STATES.broken)
	instance_destroy();


//check to see if the below wall also has shadow
with(my_wall) other.below = instance_place(x,bbox_bottom+1,obj_wall);

if(below != noone and bottom)
	with(obj_wall_shadow)
		if(my_wall == other.below) 
			other.bottom = false;

depth = DEPTH.wall-1;
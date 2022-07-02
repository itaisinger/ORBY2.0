///@description 
yoff = 0;
state = 0;
a_spd = 10;
creation_num = -1;
my_room = room; //the room that im in

if(instance_exists(obj_player))
{
	xdest = obj_player.x;
	ydest = obj_player.bbox_top-10;
}

enum SPAWN_STATES{
	create,
	natural,
	destroy,
	off,
}


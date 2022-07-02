///@description 
if(state == SPAWN_STATES.destroy) exit;

if(room != my_room)
{
	//if(file_exists(global.savefile3))
	//{
	//	file_copy(global.savefile3,global.savefile4);
	//	file_delete(global.savefile3);
	//}
	state = SPAWN_STATES.off;
}
else state = SPAWN_STATES.natural;

if(room == rm_menu) instance_destroy();
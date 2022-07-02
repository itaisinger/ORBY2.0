///@desc load savepoint
/*/
first thing load the normal file. do this from the event that calls this.
then load just the room and location within it of the savepoint.
this info is saved either in savefile3 or 4,
so just load whichever of them exists.
/*/

if(file_exists(global.savefile3))
{
	path = global.savefile3;
}
else path = global.savefile4;


if(file_exists(path))
{	
	var _wrapper = load_JSON_from_file(path);
	
	instance_destroy(obj_player);
	
	var player = instance_create_depth(0,0,0,obj_player); 
	
	//extract
	player.x = _wrapper[?"x"];
	player.y = _wrapper[?"y"];
	player.grav_amp = _wrapper[?"grav"];
	player.is_capital = _wrapper[?"capital"]
	if(path == global.savefile3)
		player.anvil_index = _wrapper[?"anvil"];
		
	//this is problematic. savpoints loads your anvil just if he is from this room.
	obj_game.load_flip_anvils = _wrapper[?"grav flipped"];
	var goto = _wrapper[? "room"];
	player.respawn_at_spawnpoint = true;
	
	room_goto(goto);
	
	ds_map_destroy(_wrapper);
	
	show_debug_message("savepoint loaded from file " + path)
}
else show_message("tried to load a checkpoint file while there is no file");

file_delete(global.savefile3);
file_delete(global.savefile4);
 
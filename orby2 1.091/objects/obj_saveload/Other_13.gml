///@desc save savepoint
//save_script(global.savefile3);

//root list
path = global.savefile3;

//wrapp up and send to jason.
var _wrapper = ds_map_create();

ds_map_add(_wrapper,"x",obj_player.x);
ds_map_add(_wrapper,"y",obj_player.y);
ds_map_add(_wrapper,"capital",obj_player.is_capital);
ds_map_add(_wrapper,"grav",obj_player.grav_amp);
ds_map_add(_wrapper,"anvil",obj_player.anvil_index);
ds_map_add(_wrapper,"grav flipped",obj_orb.grav_flipped);
ds_map_add(_wrapper,"room",room);

var _string = json_encode(_wrapper);
save_string_to_file(path,_string); 

//cleanup
ds_map_destroy(_wrapper)
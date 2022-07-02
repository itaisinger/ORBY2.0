///@description new game
if(file_exists(global.savefile))  file_delete(global.savefile);
if(file_exists(global.savefile2)) file_delete(global.savefile2);
if(file_exists(global.savefile3)) file_delete(global.savefile3);
if(file_exists(global.savefile4)) file_delete(global.savefile4);

transition(TRANS_STATES.goto,rm_level_1,0);
instance_create_depth(0,0,0,obj_newgame);
		
ds_list_destroy(list_pressed_keys);
ds_list_destroy(list_got_endings);	
ds_list_destroy(list_played_scenes);		
ds_list_destroy(list_placed_anvils);	
ds_list_destroy(list_placed_anvils_x);	
ds_map_destroy(map_disabled_distruptors);
ds_map_destroy(map_pressed_keys_by_room);
ds_map_destroy(map_picked_orbs);

map_picked_orbs				= ds_map_create();
list_pressed_keys			= ds_list_create(); //the first var isnt in use.
list_got_endings			= ds_list_create(); //the first var isnt in use.
list_played_scenes			= ds_list_create();
list_placed_anvils			= ds_list_create(); //a list of anvil id's that are placed on the button
list_placed_anvils_x		= ds_list_create(); //list of the placed anvils's x
map_disabled_distruptors	= ds_map_create();	//list of pressed disruptors
map_pressed_keys_by_room    = ds_map_create();  //pressed keys by room.
energy_deposited = 0;

global.map_run_times[?global.savefile] = 0;
//with(obj_speedrun) time = 0;
with (obj_orb) list_savepoints = ds_list_create();
save_savepoints(); //why should i save the list here?
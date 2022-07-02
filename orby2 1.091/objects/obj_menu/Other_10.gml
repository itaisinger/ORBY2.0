///@description load menu
if(file_exists(global.savefile))
{
	var _wrapper = load_JSON_from_file(global.savefile);
	var _list = _wrapper[? "ROOT"];
	
	for(var i=0; i < ds_list_size(_list); i++;)
	{
		var _map = _list[|i];
		var _obj = _map[? "obj"];
		
		if(_obj == "obj_orb")
			unlocked_colors =	ds_list_deep_clone(_map[? "unlocks_colors"]);
		if(_obj == "obj_game")
		{
			ds_list_destroy(got_endings);
			got_endings = ds_list_deep_clone(_map[? "endings"]);
		}
		if(_obj == "obj_speedrun")
		{
			if(!instance_exists(obj_speedrun)) instance_create_depth(0,0,0,obj_speedrun);
			
			list_end_times = ds_list_deep_clone(_map[? "end times"]);
		}
	}
	ds_map_destroy(_wrapper);
}
else
{
	if(variable_instance_exists(id,"unlocked_colors")) ds_list_destroy(unlocked_colors);
	ds_list_destroy(got_endings);
	
	unlocked_colors = ds_list_create();
	got_endings = ds_list_create();
}

update_menu_changes();
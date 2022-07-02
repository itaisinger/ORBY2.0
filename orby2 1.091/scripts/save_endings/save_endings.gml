function save_endings() {
	//@desc save_script()
	///@arg0path

instance_create_depth(0,0,DEPTH.ui_game,obj_effect_saving);

#region load

	var path = global.savefile;

	if(file_exists(path))
	{
		var _wrapper = load_JSON_from_file(path);
		var _list = _wrapper[? "ROOT"];
	
		for(var i=0; i < ds_list_size(_list); i++;)
		{
			var _map = _list[|i];
			var _obj = _map[? "obj"];
		
			if(_obj == "obj_game")
			with(obj_game)
			{
				ds_map_delete(_map,"endings");
				ds_map_add_list(_map,"endings",ds_list_deep_clone(list_got_endings))
					

			}
			
			else if(_obj == "obj_speedrun")
			with(obj_speedrun)
			{
				ds_map_delete(_map,"end times");
				ds_map_add_list(_map,"end times",ds_list_deep_clone(list_end_times))
				ds_map_set(_map,"time",time);
			}
		}
	
		var _string = json_encode(_wrapper);
		save_string_to_file(path,_string); 

		//cleanup
		ds_map_destroy(_wrapper);

		show_debug_message("endings saved to file " + path)
	}
	else show_message("no save file detected");

#endregion


}

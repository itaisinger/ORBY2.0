function menu_background_index() {
	//get what wall has been broken
	var wall_index = 0;
	var ends = ds_list_create();
	var l_pressed = ds_list_create();

	//look in the savefile
	if(file_exists(global.savefile))
	{
		var _wrapper = load_JSON_from_file(global.savefile);
		var _list = _wrapper[? "ROOT"];
	
		for(var i=0; i < ds_list_size(_list); i++;)
		{
			var _map = _list[|i];
			var _obj = _map[? "obj"];
		
			if(_obj == "obj_game")
			{
				ds_list_destroy(ends);
				ds_list_destroy(l_pressed);
			
				l_pressed = ds_list_deep_clone(_map[? "pressed keys"]);
				ends = ds_list_deep_clone(_map[? "endings"]);
			}
		}
		ds_map_destroy(_wrapper);
	
		//determine max pressed
		for(var i=0; i < ds_list_size(l_pressed); i++)
		{
			if(l_pressed[|i]) wall_index = i;
		}
	}

	//apply 
	var bg = layer_background_get_id("background");
	if(wall_index < 4)
	{
		layer_background_alpha(bg,1);
		layer_background_index(bg,wall_index+1);
	}
	else layer_background_alpha(bg,0);

	bg = layer_background_get_id("last_bg");

	var escape = 0;
	if(ds_list_size(ends) >= ENDINGS.escape)
	if(ends[|ENDINGS.escape])
	{
		escape = 1;
		layer_background_change(bg,spr_background_escape);
	}

	if(!escape)
		layer_background_change(bg,spr_background_last);

	ds_list_destroy(ends);
	ds_list_destroy(l_pressed);


}

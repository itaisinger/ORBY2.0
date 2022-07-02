function save_script(argument0) {
	//@desc save_script()
	///@arg0path

	instance_create_depth(0,0,DEPTH.ui_game,obj_effect_saving);

	//root list
	var path = argument0;
	var root_list = ds_list_create();
	instance_activate_all();

	with(o_save_me)
	{
		var map = ds_map_create();
		ds_list_add(root_list,map);
		ds_list_mark_as_map(root_list, ds_list_size(root_list)-1);
	
		var _obj = object_get_name(object_index); 
		ds_map_add(map,"obj",_obj);	
	 
		switch(_obj)
		{
			case "obj_player":
			ds_map_add(map,"x",x);	
			ds_map_add(map,"y",y);
			ds_map_add(map,"momx",momentum_x);
			ds_map_add(map,"momy",momentum_y);
			ds_map_add(map,"anvil_index",anvil_index);
			ds_map_add(map,"grav_amp",grav_amp);
			ds_map_add(map,"capital",is_capital);
			break;
		
			case "obj_orb":
			ds_map_add_list(map,"unlocks_colors",ds_list_deep_clone(unlocked_colors))
			ds_map_add(map,"platform_max",platform_max)
			ds_map_add(map,"pink_max",pink_max)
			ds_map_add(map,"green_max",green_max)
			ds_map_add(map,"light_max",light_max)
			ds_map_add(map,"state",state)
			break;
		
			case "obj_game":
			ds_map_add_map(map,"pressed keys by room", ds_map_deep_clone(map_pressed_keys_by_room));
			ds_map_add_list(map,"pressed keys",  ds_list_deep_clone(list_pressed_keys)); 
			ds_map_add_map(map,"picked orbs",   ds_map_deep_clone(map_picked_orbs));  
			ds_map_add_map(map,"disruptors",   ds_map_deep_clone(map_disabled_distruptors));  
			ds_map_add_list(map,"played scenes", ds_list_deep_clone(list_played_scenes));  
			ds_map_add_list(map,"placed anvils", ds_list_deep_clone(list_placed_anvils));  
			ds_map_add_list(map,"anvils x",		 ds_list_deep_clone(list_placed_anvils_x));  
			ds_map_add_list(map,"endings",		 ds_list_deep_clone(list_got_endings));  
			ds_map_add(map,"energy",energy_deposited);
			ds_map_add(map,"speedrun",global.speedrun_active);
			break;
			
			case "obj_spawn":
			ds_map_add(map,"x",x);
			ds_map_add(map,"ystart",ystart);
			ds_map_add(map,"my_room",my_room);
			break;
			
			case "obj_orb_message":
			ds_map_add_list(map,"played messages", ds_list_deep_clone(list_played_messages));
			ds_map_add(map,"keyboard",keyboard_notice);
			break;
			
			case "obj_speedrun":
			ds_map_add_list(map,"end times", ds_list_deep_clone(list_end_times));
			break;
		}
	}

	//wrapp up and send to jason.
	var _wrapper = ds_map_create();
	ds_map_add_list(_wrapper,"ROOT", root_list);
	//add the current room
	_wrapper[? "room"] = room;

	var _string = json_encode(_wrapper);
	save_string_to_file(path,_string); 

	//cleanup
	ds_map_destroy(_wrapper)
	show_debug_message("game saved at room " + room_get_name(room));


}

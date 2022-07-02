///@desc load
room_restart();
with(o_save_me) instance_destroy();
with(obj_player_dead) instance_destroy();
with(obj_player_eye) instance_destroy();

path = global.savefile;

if(file_exists(path))
{
	var _wrapper = load_JSON_from_file(path);
	var _list = _wrapper[? "ROOT"];
	
	for(var i=0; i < ds_list_size(_list); i++;)
	{
		var _map = _list[|i];
		var _obj = _map[? "obj"];
		
		with(instance_create_depth(0,0,depth, asset_get_index(_obj)))
		{
			switch(object_get_name(object_index))
			{
				case "obj_player":
				x = _map[? "x"];
				y = _map[? "y"];
				momentum_x  = _map[? "momx"];
				momentum_y  = _map[? "momy"];
				anvil_index = _map[? "anvil_index"];
				grav_amp    = _map[? "grav_amp"];
				is_capital  = _map[? "capital"] 
				break;
		
				case "obj_orb":
				ds_list_destroy(unlocked_colors);
				unlocked_colors = ds_list_deep_clone(_map[? "unlocks_colors"]);
				platform_max    = _map[? "platform_max"];
				state			= _map[? "state"];
				
				//old savefiles companility. what a joke.
				if(ds_map_exists(_map,"pink_max")) 
					pink_max = _map[?"pink_max"];
					
				if(ds_map_exists(_map,"green_max")) 
					green_max = _map[?"green_max"];
					
				if(ds_map_exists(_map,"light_max")) 
					light_max = _map[?"light_max"];
				
				if(instance_exists(obj_player))
				{
					x = obj_player.x;
					y = obj_player.y;
				}
				break;
				
				case "obj_game":
				//prevent weird multipile game_objs bug
				if(instance_number(obj_game)>1)
				{
					instance_destroy();
				}
				else
				{
					//destroy previous ds
					ds_map_destroy(map_pressed_keys_by_room);
					ds_list_destroy(list_pressed_keys);
					ds_map_destroy(map_picked_orbs);
					ds_list_destroy(list_played_scenes);
					ds_list_destroy(list_placed_anvils);
					ds_list_destroy(list_got_endings);
					//get new ds
					map_pressed_keys_by_room  = ds_map_deep_clone(_map[? "pressed keys by room"]);
					map_picked_orbs			  = ds_map_deep_clone(_map[? "picked orbs"]);
					map_disabled_distruptors  = ds_map_deep_clone(_map[? "disruptors"]);
					list_pressed_keys	      = ds_list_deep_clone(_map[? "pressed keys"]);
					list_played_scenes		  = ds_list_deep_clone(_map[? "played scenes"]);
					list_placed_anvils		  = ds_list_deep_clone(_map[? "placed anvils"]);
					list_placed_anvils_x	  = ds_list_deep_clone(_map[? "anvils x"]);
					list_got_endings		  = ds_list_deep_clone(_map[? "endings"]);
					energy_deposited = _map[?"energy"];
					global.speedrun_active = _map[?"speedrun"]
				}
				break;
				
				case "obj_spawn":
				x = _map[? "x"];
				ystart = _map[? "ystart"];
				my_room = _map[? "my_room"];
				
				//do something about this
				if(other.path == global.savefile3 or other.path == global.savefile4)
					state = SPAWN_STATES.destroy;
				break;
				
				case "obj_orb_message":
				list_played_messages = ds_list_deep_clone(_map[? "played messages"]);
				keyboard_notice = _map[? "keyboard"];
				break;
				
				case "obj_speedrun":
				ds_list_destroy(list_end_times);
				list_end_times = ds_list_deep_clone(_map[? "end times"]);
				break;
			}
		}
	}
	
	var goto = _wrapper[? "room"];

	ds_map_destroy(_wrapper);
	
	room_goto(goto);
	
	show_debug_message("game loaded from file " + path)
}
else show_message("no save file detected");

#region load savepoints list

if(file_exists(global.savefile2))
{
	var _wrapper = load_JSON_from_file(global.savefile2);
	
	if(instance_exists(obj_orb))
	{
		ds_list_destroy(obj_orb.list_savepoints);
		obj_orb.list_savepoints = ds_list_deep_clone(_wrapper[?"savepoints"])
	}
	else show_debug_message("savepoints list not loaded")
	
	ds_map_destroy(_wrapper)
}
else show_message("no savepoints file detected");
#endregion

path = "";
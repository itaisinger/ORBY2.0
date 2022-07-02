///@description update map pressed keys
ds_map_delete(map_pressed_keys_by_room,string(room));
ds_map_add_list(map_pressed_keys_by_room,string(room),ds_list_deep_clone(list_pressed_keys));

global.darkness_alpha = 0.5;
global.shadow_h = 1;
global.wall_color_index = 0;
global.light_radius_multi = 1;
global.room_is_capital = 0;

//update some spesific scenes
switch(room)
{
	/////
	case rm_purple_4:
		if(!list_played_scenes[|CUTSCENES.purple4])
		{
			list_played_scenes[|CUTSCENES.purple4] = true;
		}
		break;
}
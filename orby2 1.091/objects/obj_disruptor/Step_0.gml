///@description 

//setup colors
if(my_color_arr == -1)
{
	var	_col = colors[index];
	my_color_arr = [color_get_red(_col)/255,color_get_green(_col)/255,color_get_blue(_col)/255];
}

//setup creation num
if(creation_num == -1)
{
	creation_num = string(room) + "." + string(index);
	
	//disable myself if already pressed
	var _val = ds_map_find_value(obj_game.map_disabled_distruptors,creation_num);
	if(!is_undefined(_val) and _val == 1)
	{
		active = 0;
		button_a = 0;
		var _pos = ds_list_find_index(global.disruptors,index);
		ds_list_delete(global.disruptors,_pos);
		my_color_arr = [0.8,0.8,0.8]
	}
}

//disable
if((place_meeting(x,y-1,obj_player) or place_meeting(x,y-1,obj_miner) or place_meeting(x,y-1,obj_green)) and active) 
{
	active = 0;
	my_color_arr = [0.8,0.8,0.8]
	var _pos = ds_list_find_index(global.disruptors,index);
	ds_list_delete(global.disruptors,_pos);
	play_sfx(sfx_disruptor)
	
	//update obj_game map value
	ds_map_add(obj_game.map_disabled_distruptors,creation_num,1);
}

if(!active)
{
	button_a = lerp(button_a,0,0.2);
}
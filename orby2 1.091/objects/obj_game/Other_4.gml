///@description
#region essential objs

//recreate essential objects
if(!instance_exists(obj_saveload))     instance_create_depth(0,0,0,obj_saveload);
if(!instance_exists(obj_mouse))		   instance_create_depth(0,0,0,obj_mouse);
if(!instance_exists(obj_transition))   instance_create_depth(0,0,0,obj_transition);
if(!instance_exists(obj_input))        instance_create_depth(0,0,0,obj_input);
if(!instance_exists(obj_camera))	   instance_create_depth(0,0,0,obj_camera);
if(!instance_exists(obj_debugger))	   instance_create_depth(0,0,0,obj_debugger);
if(!instance_exists(obj_orb_message))  instance_create_depth(0,0,0,obj_orb_message);
if(!instance_exists(obj_shade_drawer)) instance_create_depth(0,0,0,obj_shade_drawer);
if(!instance_exists(obj_sfx))		   instance_create_depth(0,0,0,obj_sfx);
if(!instance_exists(obj_speedrun))	   instance_create_depth(0,0,0,obj_speedrun);
if(!instance_exists(obj_shader_disable)) instance_create_depth(0,0,0,obj_shader_disable);
if(!instance_exists(obj_music))
{
	instance_create_depth(0,0,0,obj_music);
	obj_music.update_ost();
}

#endregion
#region update pressed keys by room

//
with(obj_wall_block) event_user(0);

ds_map_delete(map_pressed_keys_by_room,string(room));
ds_map_add_list(map_pressed_keys_by_room,string(room),ds_list_deep_clone(list_pressed_keys));

#endregion
#region layers

//put all the objects in the same layer so depth will take effect.
if !layer_exists("all") layer_create(0,"all");  
if !layer_exists("ui")  layer_create(-20,"ui"); 

with(all)
{
	var my_depth = depth;
	layer = layer_get_id("all");
	depth = my_depth;
}

//push bg back


#endregion
#region cutscenes

//create cutscene objects
switch(room)
{
	case rm_pit_top:
		if(!list_played_scenes[|CUTSCENES.fall1])
		{
			list_played_scenes[|CUTSCENES.fall1] = true;
			
			with instance_create_depth(0,0,0,obj_cutscene)	
				index = CUTSCENES.fall1;
		}
		break;
	case rm_blue_exit:
		with instance_create_depth(0,0,0,obj_cutscene)	
			index = CUTSCENES.escape;
		
		break;
	case rm_pit_trailer:
		with instance_create_depth(0,0,0,obj_cutscene)	
			index = CUTSCENES.trailer;
		
		break;
	case rm_pit_middle:
		if(!list_played_scenes[|CUTSCENES.fall2])
		{
			list_played_scenes[|CUTSCENES.fall2] = true;
			
			with instance_create_depth(0,0,0,obj_cutscene)	
				index = CUTSCENES.fall2;
		}
		break;
		
	case rm_pit_bottom:
		if(!list_played_scenes[|CUTSCENES.fall3])
		{
			list_played_scenes[|CUTSCENES.fall3] = true;
			
			with instance_create_depth(0,0,0,obj_cutscene)	
				index = CUTSCENES.fall3;
		}
		break;
		
	case rm_level_1:
		if(!list_played_scenes[|CUTSCENES.start])
		{
			list_played_scenes[|CUTSCENES.start] = true;
			
			with instance_create_depth(0,0,0,obj_cutscene)	
				index = CUTSCENES.start;
		}
		break;
	
	case rm_purple_enter:
		if(!list_played_scenes[|CUTSCENES.right_click])
		{
			//mark this cutscene as played from the cutscene object.
			with instance_create_depth(0,0,0,obj_cutscene)	
				index = CUTSCENES.right_click;
		}
		break;
		
		case rm_purple_5:
		if(!list_played_scenes[|CUTSCENES.multijump])
		{
			with instance_create_depth(0,0,0,obj_cutscene)	
				index = CUTSCENES.multijump;
		}
		break;
		
	case rm_dark_4:
		if(!list_played_scenes[|CUTSCENES.light])
		{
			with instance_create_depth(0,0,0,obj_cutscene)	
				index = CUTSCENES.light;
		}
		break;
	case rm_blue_1:
		if(!list_played_scenes[|CUTSCENES.blue1])
		{
			with instance_create_depth(0,0,0,obj_cutscene)	
				index = CUTSCENES.blue1;
		}
		break;
		
	case rm_blue_palace:
		with instance_create_depth(0,0,0,obj_cutscene)	
		{
			if(other.list_got_endings[|ENDINGS.turnover])
				index = CUTSCENES.turnover_capital;
			else
				index = CUTSCENES.turnover;
			
			#region disable scene if already done
			
			if(other.list_got_endings[|ENDINGS.kinghood])
			{
				//destroy the block
				with(obj_wall_block_finale) other.anvil = instance_place(x,bbox_top-1,obj_anvil);
				instance_destroy(obj_wall_block_finale);							
				
				//create the body
				var body_y = instance_place(obj_king.x,obj_king.y+64,obj_wall).bbox_top-1;
				var body = instance_create_depth(obj_king.x,body_y,DEPTH.player,obj_player_dead_squashed_v)
				instance_destroy(obj_king)
				
				with(body)
				{
					sprite_index = spr_capital;
					eyeout_spr = spr_capital_eyeout;
					min_y = 0.2;
					image_yscale = 0.2;
					image_xscale = 1.3;		
					killer = other.anvil;
				}
				
				//magnet the anvil
				anvil.y = body.bbox_top-anvil.sprite_height;
				
				with(obj_capital) state = CAPITAL_STATES.bow;
				instance_destroy();
			}
			
			#endregion
		}
	break;
	
	case rm_pink_hub:
		with(instance_create_depth(0,0,0,obj_cutscene))
		{
			index = CUTSCENES.pink_hub;
		}
}

//mark scenes as played when the player picked the orb

list_played_scenes[|CUTSCENES.reward1] = global_get_orb_picked(REWARD_ID.reward1);
list_played_scenes[|CUTSCENES.reward2] = global_get_orb_picked(REWARD_ID.reward2);
list_played_scenes[|CUTSCENES.reward3] = global_get_orb_picked(REWARD_ID.reward3);
list_played_scenes[|CUTSCENES.reward4] = global_get_orb_picked(REWARD_ID.reward4);
list_played_scenes[|CUTSCENES.reward5] = global_get_orb_picked(REWARD_ID.reward5);

#endregion
#region save game

if(!instance_exists(obj_credits))
{
	//artificial room start
	with(obj_spawn)  event_user(0);
	with(obj_player) event_user(0); 

	if(room != rm_menu and save_game == 1)
	{
		save_game = 0;
		with(obj_saveload) event_user(SAVELOAD.save);
	}

	//move file3 to 4
	if(file_exists(global.savefile3))
	{
		file_copy(global.savefile3,global.savefile4);
		file_delete(global.savefile3);
	}
}

#endregion
#region more vars

if(variable_global_exists("disruptors"))
	ds_list_destroy(global.disruptors);
global.disruptors = ds_list_create();
with(obj_disruptor) add_index();

////wall colors////

//capital
if(string_part(room_get_name(room),1,7) == "rm_blue")
{
	global.wall_color_arr = wall_colors[3];
}
//pink
else if(string_part(room_get_name(room),1,7) == "rm_pink")
{
	global.wall_color_arr = wall_colors[1];
}
//default
else global.wall_color_arr = wall_colors[0];

#endregion
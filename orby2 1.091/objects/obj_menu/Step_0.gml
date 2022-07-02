///@description 
if(instance_exists(obj_opening_scene) and !obj_opening_scene.destroy) exit;

#region update color

var m_col = c_white;  
var o_col = c_black;
if(instance_exists(obj_menu_orb))
{
	o_col = get_colors(obj_menu_orb.color);
	m_col = get_colors_background(obj_menu_orb.color);
}

title_inst.outline_color = o_col;
title_inst.color = m_col;
if(instance_exists(obj_menu_text))
with(obj_menu_text) outline_base_color = o_col;

#endregion
#region actions

var w = camera_get_view_width(view_current);
var h = camera_get_view_height(view_current);

if(return_value_next != "")
{
	return_value = return_value_next;
	return_value_next = "";
}
if(return_value != "")
{
	switch(return_value)
	{
		case "load":
			transition(TRANS_STATES.load);
			break;
		//////////////////////////
		case "new":
		if(file_exists(global.savefile))
		{
			#region confirm menu
		
			//delete the current menu
			with(obj_menu_text) instance_destroy();
			ds_list_clear(text_insts);
			y = bottom_pos;
		
			//"confirm?"
			with(instance_create_depth(x,h/2,0,obj_text))
			{
				ds_list_add(other.text_insts,self);
				text = "delete current save file\nand start a new game?";
				scale = 1;
				outline_width = 2;
				color = c_black;
				valign = fa_middle;
			}
			
			//create the new options
			
			//confirm
			with(instance_create_depth(x,h/2+200,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "confirm";
				return_value = "new_confirm";
				scale = 1.5;
			}
		
			//cancel
			with(instance_create_depth(x,h/2+300,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "cancel";
				return_value = "back_main";
				scale = 1.5;
			}
		
			#endregion
		}
		else with(obj_game) event_user(GAME_EVENTS.new_game);
		break;
		//////////////////////////
		case "quit":
			game_end();
		break;
		////////////////////////	
		case "back_main":
		#region return to main menu
		
		//delete the current menu
		with(obj_menu_text) instance_destroy();
		instance_destroy(text_insts[|0]);
		ds_list_clear(text_insts);
		y = bottom_pos;
		text_scale = 1.4;
		
		//load
		with(instance_create_depth(x,h*2,0,obj_menu_text))
		{
			ds_list_add(other.text_insts,self);
			parent = other;
			text = "load game";
			return_value = "load";
	
			if(!file_exists(global.savefile))
				state = TEXT_STATES.off;
		}
		
		//new
		with(instance_create_depth(x,h*2,0,obj_menu_text))
		{
			ds_list_add(other.text_insts,self);
			parent = other;
			text = "new game";
			return_value = "new";
		}
		
		//options
		with(instance_create_depth(x,h*2,0,obj_menu_text))
		{
			ds_list_add(other.text_insts,self);
			parent = other;
			text = "options";
			return_value = "options";
		}
		
		//quit
		with(instance_create_depth(x,h*2,0,obj_menu_text))
		{
			ds_list_add(other.text_insts,self);
			parent = other;
			text = "quit";
			return_value = "quit";	
		}
		
		#endregion
		break;
		/////////////////////////////
		case "new_confirm":
		#region new savefile
			with(obj_game) event_user(GAME_EVENTS.new_game);
		#endregion
		break;
		////////////////////////////
		case "options":
		#region options menu
		
			//delete the current menu
			with(obj_menu_text) instance_destroy();
			with(obj_typer) instance_destroy();
			ds_list_clear(text_insts);
			y = bottom_pos;
			
			//create the new options
			text_scale = 1.2;
			
			//controls options
			with(instance_create_depth(x,h*2,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "controls options";
				return_value = "options_controls";
				scale = 1.2;
			}
			
			//sound options
			with(instance_create_depth(x,h*2,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "sound options";
				return_value = "options_sound";
				scale = 1.2;
			} 
			
			//set savefile name
			with(instance_create_depth(x,h*2+200,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "set savefile name";
				return_value = "options_save";
				scale = 1.2;
			}
			
			//fullscreen
			with(instance_create_depth(x,h*2+200,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "toggle fullscreen";
				return_value = "options_fullscreen";
				scale = 1.2;
			}
			
			//speedrun
			with(instance_create_depth(x,h*2+200,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "speedrun mode";
				return_value = "options_speedrun";
				scale = 1.2;
			}
			
			//back to main menu
			with(instance_create_depth(x,h*2,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "back";
				return_value = "back_main";
				scale = 1.5;
			}
		
		#endregion
		break;
		///////////////
		#region controls
		case "options_controls":
		#region options controls
		
			//delete the current menu
			with(obj_menu_text) instance_destroy();
			with(obj_typer) instance_destroy();
			ds_list_clear(text_insts);
			y = bottom_pos;
			
			//create the new options
			text_scale = 1;
			
			//set awsd
			with(instance_create_depth(x,h*2,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "set awsd controls";
				return_value = "options_awsd";
				scale = 1.2;
			}
	
			//set arrows
			with(instance_create_depth(x,h*2,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "set arrows controls";
				return_value = "options_arrows";
				scale = 1.2;
			} 
			
			//jump with up
			with(instance_create_depth(x,h*2,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "toggle jump with up";
				return_value = "options_jump";
				scale = 1.2;
			} 
			
			//back to options
			with(instance_create_depth(x,h*2,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "back";
				return_value = "options";
				scale = 1.2;
			}
		
		#endregion
		break;
		///////////////
		case "options_bind":
		#region set key bindings
		
		//delete the current menu
		with(obj_menu_text) instance_destroy();
		with(obj_typer) instance_destroy();
		ds_list_clear(text_insts);
		y = bottom_pos;
		
		#endregion
		break;
		///////////////
		case "options_awsd":
		#region set awsd controls
		
		obj_input.bind_down  = ord("S");
		obj_input.bind_up    = ord("W");
		obj_input.bind_left  = ord("A");
		obj_input.bind_right = ord("D");
		obj_input.bind_jump  = vk_space;
		
		text_fade("awsd controls set",-window_get_height()/3,o_col);
		
		#endregion
		break;
		///////////////
		case "options_jump":
		#region set jump with up
		
		obj_input.jump_with_up = !obj_input.jump_with_up;
		
		var _text = "";
		if(!obj_input.jump_with_up)
			_text += "not "
				
		_text += "jumping with up";
		text_fade(_text,-window_get_height()/3,o_col);
		
		#endregion
		break;
		///////////////
		case "options_arrows":
		#region set arrows controls
		
		obj_input.bind_down  = vk_down;
		obj_input.bind_up    = vk_up;
		obj_input.bind_left  = vk_left;
		obj_input.bind_right = vk_right;
		obj_input.bind_jump  = vk_up;
		
		text_fade("arrows controls set", -window_get_height()/3,o_col);
		
		#endregion
		break;
		#endregion
		///////////////
		#region sound
		case "options_sound":
		#region options sound
		
			//delete the current menu
			with(obj_menu_text) instance_destroy();
			with(obj_typer) instance_destroy();
			ds_list_clear(text_insts);
			y = bottom_pos;
			
			//create the new options
			text_scale = 1.2;
			
			//music+
			with(instance_create_depth(x,h*2+200,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "music volume +";
				return_value = "music_up";
				scale = 1.2;
			}
			//music-
			with(instance_create_depth(x,h*2+200,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "music volume -";
				return_value = "music_down";
				scale = 1.2;
			}
			
			//sfx+
			with(instance_create_depth(x,h*2+200,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "sfx volume +";
				return_value = "sfx_up";
				scale = 1.2;
			}
			//sfx-
			with(instance_create_depth(x,h*2+200,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "sfx volume -";
				return_value = "sfx_down";
				scale = 1.2;
			}
			
			//back to main menu
			with(instance_create_depth(x,h*2,0,obj_menu_text))
			{
				ds_list_add(other.text_insts,self);
				parent = other;
				text = "back";
				return_value = "options";
				scale = 1.5;
			}
		
		#endregion
		break;
		///////////////
		case "music_up":
		#region music up
			global.music_volume = approach(global.music_volume,0.1,1);
			
			var _text = string(floor(global.music_volume*10));
			text_fade("music volume: " + _text,-window_get_height()/3,o_col);
		#endregion
		break;
		///////////////
		case "music_down":
		#region music down
			global.music_volume = approach(global.music_volume,0.1,0);
			
			var _text = string(floor(global.music_volume*10));
			text_fade("music volume: " + _text,-window_get_height()/3,o_col);
		#endregion
		break;
		///////////////
		case "sfx_up":
		#region sfx up
			global.sfx_volume = approach(global.sfx_volume,0.1,1);
			
			var _text = string(floor(global.sfx_volume*10));
			text_fade("sfx volume: " + _text,-window_get_height()/3,o_col);
		#endregion
		break;
		///////////////
		case "sfx_down":
		#region sfx up
			global.sfx_volume = approach(global.sfx_volume,0.1,0);
			
			var _text = string(floor(global.sfx_volume*10));
			text_fade("sfx volume: " + _text,-window_get_height()/3,o_col);
		#endregion
		break;
		#endregion
		///////////////
		case "options_save":
		#region set savefile name
		
		//delete the current menu
		with(obj_menu_text) instance_destroy();
		ds_list_clear(text_insts);
		y = bottom_pos;

		//create the new options
		
		//confirm
		with(instance_create_depth(x,h*2,0,obj_menu_text))
		{
			ds_list_add(other.text_insts,self);
			parent = other;
			text = "confirm";
			return_value = "options_save_confirm";
			scale = 1.2;
		}
		
		//typer
		with(instance_create_depth(x,h*2,0,obj_typer))
		{
			ds_list_add(other.text_insts,self);
			parent = other;
			scale = 1.2;
			outline_width = 3;
			keyboard_string = string_delete(global.savefile,string_length(global.savefile)-3,4);
		}
		
		//defualt
		with(instance_create_depth(x,h*2,0,obj_text))
		{
			ds_list_add(other.text_insts,self);
			parent = other;
			text = "defualt is \"save\"";
			scale = 1;
			outline_width = 3;
		}
		
		#endregion
		break;
		//////////////
		case "options_save_confirm":
		#region confirm savefile name
		
		var newname = obj_typer.text;
		global.savefile  = newname + ".sav";
		global.savefile2 = newname + "2.sav";
		global.savefile3 = newname + "3.sav";
		global.savefile4 = newname + "4.sav";
		
		with(obj_menu_orb) event_user(0);
		menu_background_index();
		obj_music.update_ost();
		
		//last save file
		file_delete(global.savefile_last);
		
		var map = ds_map_create();
		ds_map_add(map,"name",newname);
		
		var str = json_encode(map);
		save_string_to_file(global.savefile_last,str);
		ds_map_destroy(map);
		
		//load relevent info from new savefile
		event_user(0);
		
		return_value_next = "options";
		instance_destroy(text_insts[|2]);
		
		#endregion
		break;
		//////////////
		case "options_fullscreen":
		#region fullscreen
		
		if(window_get_fullscreen())	window_set_fullscreen(0);
		else window_set_fullscreen(1);
		
		#endregion
		break;
		//////////////
		case "options_speedrun":
		#region speedrun
		
		global.speedrun_active = !global.speedrun_active;
		
		var _text = "speedrun mode ";
		if(global.speedrun_active) _text += "on";
		else _text += "off";
		
		text_fade(_text,-window_get_height()/3,o_col);
		
		#endregion
		break;
	}
	return_value = "";
}
 
#endregion
#region self movement

ydest = h/2;
bottom_pos = h*1.5;

var spd = abs(y-ydest)/7;
spd = max(1,spd);

y = approach(y,spd,ydest);
x = camera_get_view_width(view_current)/2;

#endregion
#region update end text

//set the endings strings to show score
for(var i=0; i<5; i++)
{
	//reset the text
	end_insts[|i].text = end_strings[i];
			
	//add the time if needed
	var os = obj_speedrun;
	if(os.active and os.list_end_times[|max(0,i-1)] != 0)
		end_insts[|i].text += " (" + os.time_to_string(os.list_end_times[|i-1]) + ")";
}

#endregion
#region update positions

title_inst.y = h/2-150;
title_inst.x = x;
var yy = y;
var margin = 10*(text_scale/1.4);
draw_set_font(font_message);

for(var i=0; i<ds_list_size(text_insts); i++)
{
	with(text_insts[|i])
	{
		if(object_get_name(object_index) == "obj_menu_text")
		{
			xstart = other.x;
			ystart = yy;
			scale = other.text_scale;
			color_base = m_col;
			outline_base_color = o_col;
			outline_width = 3;
		}
		else
		{
			x = other.x;
			color = m_col;
			outline_color = o_col;
			y = yy;
		}
	}
	
	
	yy += margin + text_insts[|i].scale*string_height(text_insts[|i].text);
}
build_inst.y = h;
build_inst.x = 10;
build_inst.text = "active savefile:\n" + global.savefile + "\nbuild: " + string(global.version);

//endings got
var yy = h/2;

for(var i = 0; i<ds_list_size(end_insts); i++;)
{
	var _end_achived = got_endings[|max(0,i-1)] or (i == 0 and ds_list_size(got_endings));
	var _inst = end_insts[|i];
	var _xdest = w + 200 - (200+string_width(_inst.text)*_inst.scale+15)*(_end_achived);
	
	_inst.x = lerp(_inst.x,_xdest,0.1);
	_inst.outline_color = o_col;
	_inst.color = m_col;
	_inst.scale = 0.7;
	_inst.y = yy;
	yy += (string_height(_inst.text)*_inst.scale+5)*(_end_achived);
}

//extras
var _ends = ds_list_create();
for(var i=0; i<4; i++;)
{
	if(i<ds_list_size(got_endings))
		_ends[|i] = got_endings[|i];
	else
		_ends[|i] = 0;
}

var _ydest = -200 + 430*(_ends[|ENDINGS.kinghood])
inst_crown.y = lerp(inst_crown.y,_ydest,0.1);
inst_crown.x = camera_get_view_width(view_current)/2;

var _xdest = -300 + 330*(_ends[|ENDINGS.obedience])
inst_miner.x = lerp(inst_miner.x,_xdest,0.1);

ds_list_destroy(_ends);
#endregion
#region background

var lay_id = layer_get_id("background");
if(layer_exists(lay_id))
{
	var bg_spd = layer_get_hspeed(lay_id);
	layer_hspeed(lay_id,max(bg_spd-0.3,2))
}
else show_message("no layer found")

#endregion
#region destruction miners

with(obj_miner) if(bbox_top > room_height)
{
	instance_destroy();
}

#endregion
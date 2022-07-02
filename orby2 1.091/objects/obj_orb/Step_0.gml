#region vars management

depth = DEPTH.orb;
state_changed = 0;

//unlock orbs
if(state_anim = ORB_ANIMS.natural and ds_list_size(unlock_list) > 0)
{
	state_anim = ORB_ANIMS.unlocked;
	flash_color = unlock_list[|0];
	flash_a = 1.3;
	
	if(!unlocked_colors[|unlock_list[|0]])
		unlocked_colors[|unlock_list[|0]] = true;
	
	//more platforms
	else if(unlock_list[|0] == COLORS.purple)
	{
		platform_max++
	}
	//more pink
	else if(unlock_list[|0] == COLORS.pink)
	{
		pink_max++
	}
	//more yellow
	else if(unlock_list[|0] == COLORS.yellow)
	{
		light_max++
	}
	//more green
	else if(unlock_list[|0] == COLORS.green)
	{
		green_max++;
		green_remain++;
	}
		
	ds_list_delete(unlock_list,0);
	play_sfx(sfx_consume);
}


//reset platform uses
if(instance_exists(obj_player))
{
	with (obj_player) other.wall_inst = instance_place(x,y+sign(grav_amp), obj_pre_solid);
		if(wall_inst != noone)
			if(!wall_inst.is_made)
			{
				platform_current = platform_max;
			}
}

if(platform_current != platform_current_prev)
{
	for(var i=platform_current_prev; i < platform_max; i++)
	{
		if(i < array_length(platform_display_sizes))
			platform_display_sizes[i] = platform_display_base*1.4;
	}
}
platform_current_prev = platform_current;


//reset grav used is done from the anvils
var _used = grav_used;
with(obj_anvil)		   if(ground) other.grav_used = 0;
with(obj_anvil_pickup) if(ground) other.grav_used = 0;
with(obj_player)	   if(ground == 1 and anvil_index != -1) other.grav_used = 0;

//sfx

//destroy follow inst
if(state != COLORS.black and instance_exists(follow_inst))
{
	instance_destroy(follow_inst);
	follow_inst = noone;
}

//disbaled menu when switching color
if(menu_mode and state != ORB_STATES.black)
{
	menu_mode = 0;
	is_anchored = 0;
	instance_destroy(text_create);
	instance_destroy(text_load);
}

//create and load text insts
with(text_create)
{
	//logic
	if(!ds_list_size(other.list_savepoints))
		state = TEXT_STATES.off;
	
	//scale
	scale = lerp(scale,0.8*other.menu_mode,0.15);
	if(scale < 0.1 and !other.menu_mode) instance_destroy();
	
	//pos
	xstart = other.x;
	ystart = other.y-other.radius/2+3;
}
with(text_load)
{
	//logic
	if(!file_exists(global.savefile4) and !file_exists(global.savefile3))
		state = TEXT_STATES.off;
	
	//scale
	scale = lerp(scale,0.8*other.menu_mode,0.15);
	if(scale < 0.1 and !other.menu_mode) 
		instance_destroy();
	
	//pos
	xstart = other.x;
	ystart = other.y+other.radius/2-3;
}


#endregion
#region mask

//make the collision mask match the draw output.
switch(draw_mode)
{
	case DRAW_MODES.natural:
	
		//avoid sacling into orb walls
		if(!collision_rectangle(x-radius-1,y-radius-1,x+radius+1,y+radius+1,obj_wall_orb,0,0))
		{
			image_xscale = radius*2/sprite_get_width(mask_index);
			image_yscale = radius*2/sprite_get_height(mask_index);
		}
		break;
		
	case DRAW_MODES.rec:
		image_xscale = rec_w/sprite_get_width(mask_index);
		image_yscale = rec_h/sprite_get_height(mask_index);
		break;
}

#endregion
#region movement

var spd = 0;
if(!is_anchored)
{
	xdest = mouse_x;
	ydest = mouse_y;
	spd_max = approach(spd_max,0.2,30);
	
	var spd = point_distance(x,y, xdest,ydest)/4;
	if(place_meeting(x,y,obj_anti_orb)) spd = max(4,spd/2);
	var dir  = point_direction(x,y, mouse_x, mouse_y);
	var xspd = abs(lengthdir_x(spd, dir))
	var yspd = abs(lengthdir_y(spd, dir))
	xspd = clamp(xspd,-spd_max,spd_max)
	yspd = clamp(yspd,-spd_max,spd_max)
	
	xspd = clamp(xspd,1,50);
	yspd = clamp(yspd,1,50);
	
	var xdir = sign(xdest - x);
	var ydir = sign(ydest - y);
	
	//collision
	for(var i=0; i<xspd; i++)
	{
		if(!place_meeting(x+xdir,y,obj_orb_solid))
			x = approach(x,1,xdest)
	}
	for(var i=0; i<yspd; i++)
	{
		if(!place_meeting(x,y+ydir,obj_orb_solid))
			y = approach(y,1,ydest)
	}
	
	//soft collision
	//var _inst = instance_place(x,y,obj_anti_orb)
	//if(_inst != noone)
	//{
	//	var _point = [(_inst.bbox_right+_inst.bbox_left)/2,(_inst.bbox_bottom+_inst.bbox_top)/2];
	//	var _dir = point_direction(_point[0],_point[1],x,y);
	//	var _len = 64-distance_to_point(_point[0],_point[1])
	//	var _xx = lengthdir_x(_len,_dir);
	//	var _yy = lengthdir_y(_len,_dir);
		
	//	x += _xx;
	//	y += _yy;
	//}
}

#endregion
#region change color

var _state = state;
var can_switch = menu_mode == 0 and state_action == 0 and list_sum(unlocked_colors) and room != rm_menu and !instance_exists(obj_pause)
if(can_switch)
{
	var sf_state = state;
	disabled = 0;
	#region mouse wheel
	
	if(key_down)
	{
		state++;
		if(state >= ds_list_size(unlocked_colors))
				state = 0;
			
		while(!unlocked_colors[|state])
		{
			state++;
			if(state >= ds_list_size(unlocked_colors))
				state = 0;
		}
	}
	if(key_up)
	{
		state--;
		if(state < 0)
			state = ds_list_size(unlocked_colors)-1;
		
		while(!unlocked_colors[|state])
		{
			state--
			if(state < 0)
				state = ds_list_size(unlocked_colors)-1;
		}
	}
	
	#endregion
	#region nums
	
	var _s = state;
	
	if(key_black  and unlocked_colors[|ORB_STATES.black])  state = ORB_STATES.black;
	if(key_purple and unlocked_colors[|ORB_STATES.purple]) state = ORB_STATES.purple;
	if(key_orange and unlocked_colors[|ORB_STATES.orange]) state = ORB_STATES.orange;
	if(key_yellow and unlocked_colors[|ORB_STATES.yellow]) state = ORB_STATES.yellow;
	if(key_blue   and unlocked_colors[|ORB_STATES.blue])   state = ORB_STATES.blue;
	if(key_pink   and unlocked_colors[|ORB_STATES.pink])   state = ORB_STATES.pink;
	if(key_green  and unlocked_colors[|ORB_STATES.green])  state = ORB_STATES.green;
	
	if(_s != state) obj_orb_message.keyboard_notice += 8;
	
	#endregion
	
	if(sf_state != state)
		play_sfx(sfx_hover);
}

if(state != _state)
	state_changed = 1;

//shake
if(!can_switch and (key_down or key_up))
{
	if(!audio_is_playing(sfx_error_small))
		play_sfx(sfx_error_small);
	error_frames_menu = 10;
}

//auto change to menu
if(room == rm_menu or instance_exists(obj_pause) and state != ORB_STATES.menu)
{
	state_prev = state;
	state = ORB_STATES.menu;
}

#endregion
#region action states

//putting this here so color spesific codes could change it.
radius_dest = base_radius;

if(place_meeting(x,y,obj_button) and key_1)
{
	var button = instance_place(x,y,obj_button);
	button.pressed = true;
	key_1 = 0;
}

//disruptor
if(ds_list_find_index(global.disruptors,state) != -1 and key_1)
{
	key_1 = 0;
	play_sfx(sfx_error);
	error_frames = 20;
	message_full = obj_orb_message.messages_strs[MESSAGES.disruptor];
}


event_user(state);

#endregion
#region visuals

switch(state_anim) 
{
	case ORB_ANIMS.natural:
	#region natural
	
	//fix size
	radius = lerp(radius,radius_dest,0.15);
	//draw_s = lerp(draw_s,1,0.15);
	
	#endregion
	break;
	
	case ORB_ANIMS.create:
	#region create
	
	//draw_s = approach(draw_s, 0.05, 1);
	//if(draw_s == 1)
	//	state_anim = ORB_ANIMS.natural;
	radius = approach(radius, 0.05, base_radius);
	if(radius == base_radius)
		state_anim = ORB_ANIMS.natural;
		
	#endregion
	break;	
	
	case ORB_ANIMS.unlocked:
	#region unlocked
	
	counter_anim++;
	
	//switch(anim_phase)
	//{
	//	case 0:
	//	draw_s -= 0.03125;
	//	if(counter_anim == 10)
	//	{
	//		anim_phase++;	
	//		counter_anim = 0;
	//	}
	//	break;
	//	/////////////
	//	case 1:
	//	if(menu_mode)
	//		draw_s = approach(draw_s,0.02,4);
	//	else
	//		draw_s = approach(draw_s,0.02,1.25);
		
	//	if(draw_s == 1.25 and !menu_mode) or (draw_s == 4 and menu_mode)
	//		anim_phase++;
	//	break;
	//	////////////////
	//	case 2:
	//	draw_s = approach(draw_s,0.02,1);
	//	if(draw_s == 1)
	//	{
	//		state_anim = ORB_ANIMS.natural;
	//		counter_anim = 0;
	//		anim_phase = 0;
	//	}
	//	break;
	//}
	switch(anim_phase)
	{
		case 0:		
		radius -= 0.25;
		if(counter_anim == 10)
		{
			anim_phase++;	
			counter_anim = 0;
		}
		break;
		/////////////
		case 1:
		if(menu_mode)
			radius = approach(radius,0.1,menu_mode_radius);
		else
			radius = approach(radius,0.1,base_radius);
		
		if(radius == base_radius and !menu_mode) or (radius == menu_mode_radius and menu_mode)
			anim_phase++;
		break;
		////////////////
		case 2:
			state_anim = ORB_ANIMS.natural;
			counter_anim = 0;
			anim_phase = 0;
		break;
	}
	
	#endregion
	break;
}

flash_a = approach(flash_a,0.05,0);
 
//orb menu
if(key_2)
{
	menu_active = !menu_active;
	
	//sfx
	if(menu_active) play_sfx(sfx_menu_on);
	else		    play_sfx(sfx_menu_off);
}

#endregion
#region messages

if(message_full != "" and !instance_exists(obj_pause))
{
	if(message_full == message_prev) //continue writing the message
	{
		if(message_cd > 0) message_cd--;
		else
		{
			//cooldown
			 message_cd = 2 + int64(string_char_at(message_full,1));
		
			//next char
			if(message_current != message_full)
			{
				message_current += string_char_at(message_full,string_length(message_current)+1);
				if(string_length(message_current)>4)
				{
					audio_sound_pitch(sfx_msg,1.1-0.06*message_cd)
					play_sfx(sfx_msg);	
				}
			}
		}
	}
	else //switch message and reset the vars
	{
		message_current = "";
		message_cd		= int64(string_part(message_full,2,4));
	}
}
else message_current = "";
message_prev = message_full;

if(state_changed and message_current != "")
{
	message_full = "";
}

#endregion
#region camera

if(key_anchor) obj_camera.is_anchored = !obj_camera.is_anchored

#endregion
#region sound

//refill
if(platform_current > platform_prev and !audio_is_playing(sfx_place) and !audio_is_playing(sfx_consume) and !audio_is_playing(sfx_intro))
{
	play_sfx(sfx_refill);
}
platform_prev = platform_current;

//clang
if(_used and !grav_used)
{
	//now obj_sfx does this.
}

//light
if(state == ORB_STATES.yellow)
{
	if(!audio_is_playing(sfx_light))
		light_sfx = audio_play_sound(sfx_light,0,0);
}
else if(audio_is_playing(sfx_light))
	audio_stop_sound(sfx_light);

//light volume
light_volume = max(0.4,light_volume-0.01,min(spd/10,1));

if(audio_sound_get_track_position(light_sfx) < intro_length) light_volume = 0.8;

audio_sound_gain(light_sfx,light_volume,0);

#endregion
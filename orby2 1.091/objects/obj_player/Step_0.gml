if(instance_exists(obj_pause) or (killer != noone and killer.object_index != obj_power_plant) or
	is_paused or (dead and instance_exists(obj_player_dead))) exit;
	
#region update vars

i_frames = approach(i_frames,1,0);

//udpate is_capital 
if(instance_exists(obj_game))
{
	if(obj_game.list_got_endings[|ENDINGS.turnover])
		is_capital = 1;
	if(obj_game.list_got_endings[|ENDINGS.kinghood])
		is_king = 1;
}


xs_dest = 1;
ys_dest = 1;

//has anvil
has_anvil = (anvil_index != -1);

//avnil stats
spd = base_spd;

if(has_anvil)
	grav = grav_anvil*grav_amp;
else
{
	grav_amp = 1;
	grav = base_grav;
	
	//float grav
	if(floating)
		    grav = float_grav;
	else
	{
		float_reset_used = 0;
		grav = base_grav;
	}
}

if(hard_grav != -1)
	grav = hard_grav;

////ground////

//miner
var _miner_freeze = 0, _miners = ds_list_create();
instance_place_list(x,y+1*sign(grav),obj_green,_miners,0);

for(var i=0; i < ds_list_size(_miners); i++)
{
	if(_miners[|i].frozen) 
		 _miner_freeze = 1;
}

//solid
var ground_prev = ground;
ground = approach(ground, 0.1, place_meeting(x,y+1*sign(grav),obj_solid) or		//ground by wall
		(!is_capital and place_meeting(x,y+1*sign(grav),obj_wall_capital))		//ground by capital wall
			or _miner_freeze);													//ground by standing on frozen miner
if(ground > ground_prev) ground = 1;

if(!ground_prev and ground and !has_anvil and !creating)
{
	draw_xs = 1.3 + 0.3*first;
	draw_ys = 0.7 - 0.3*first;
	first = 0;
	if(!audio_is_playing(sfx_bump))
		play_sfx(sfx_land);
	audio_stop_sound(sfx_jump);
	audio_stop_sound(sfx_jump_long);
}

if(ground) creating = false;


#region jump amp

//jump_ampx = approach(jump_ampx,0.05,1);
//jump_amp is reset in orb event and jump_ampx in alarm[0].

if(instance_exists(obj_orb) and obj_orb.state = ORB_STATES.orange)
{
	//vertical
	if(obj_orb.state_action = JUMPER_STATES.flor)
	{
		//vertical boost
		image_yscale = 1.5;
		if(place_meeting(x,y+5*sign(grav), obj_orb))
		{
			set_jump_amp();
		}
		//horizontal boost
		else if(jump_amp == 1)
		{
			image_yscale = 1;
			image_xscale = 1.25;
			if(place_meeting(x,y, obj_orb))
			{
				set_jump_ampx();
			}
			image_xscale = 1;
		}
	
		image_yscale = 1;
	}
	
	//horizontal
	if(obj_orb.state_action == JUMPER_STATES.wall)
	{
		//horizontal boost
		image_xscale = 1.35;
		if(place_meeting(x,y, obj_orb))
		{
			set_jump_ampx()
		}
		//vertical boost	
		else if(jump_ampx == 1)
		{
			image_yscale = 1.5;
			image_xscale = 1;
			if(place_meeting(x,y-5, obj_orb))
			{
				set_jump_amp()			
			}
			image_yscale = 1;
		}
	
		image_xscale = 1;
	}

}

#endregion //jump amp


#endregion
#region squash

if(!global.flag_power_plant)
{
	var sq_dest = 0;
	
	if(has_anvil)
	{
		sq_off  = approach(sq_off,0.3,sq_dest);
		draw_xs = approach(draw_xs,0.03,xs_dest);
		draw_ys = approach(draw_ys,0.03,ys_dest);
	}
	else
	{
	
		var squash_dir = sign(grav_amp)*(key_down-key_up);
		if(squash_dir != 0)
		{
			if(squash_dir > 0)
			{
				xs_dest = 1.2;
				ys_dest = 0.7;
				sq_dest = 3*sign(grav);
			}
			if(squash_dir < 0)
			{
				xs_dest = 0.7;
				ys_dest = 1.2;
				sq_dest = -3*sign(grav);
			}
		}
	}

	var _spd = 0.03;
	if(floating) _spd = 0.01;

	if(bow)
	{
		xs_dest = 1.3;
		ys_dest = 0.7;
		_spd /= 3;
	}

	sq_off  = approach(sq_off,_spd*10,sq_dest);
	draw_xs = approach(draw_xs,_spd,xs_dest);
	draw_ys = approach(draw_ys,_spd,ys_dest);
}

#endregion //squash
#region convert input to vars

if(has_control)
{

//horizontal movement
hsp = spd*(key_right - key_left);

//jumping
if(key_jump)
{
	if((ground > 0 and vsp > -0.1) or jump_ampx != 1 or jump_amp != 1) //jump
	{
		float_reset_used = 0;
		key_jump = 0;
		vsp = -jumpforce*jump_amp*sign(grav);												//////// new
		
		//horizontal jump ampx
		if(jump_ampx != 1)
			momentum_x = jumpforce*1.3*jump_ampx*sign(x-obj_orb.x);
		
		if(jump_amp == 1 and jump_ampx == 1)
		{
			jump_sound_id = play_sfx(sfx_jump);
			audio_sound_gain(jump_sound_id,0.7*global.sfx_volume,0);
		}
		else
		{
			jump_sound_id = play_sfx(sfx_jump_long);
			audio_sound_gain(jump_sound_id,0.15,0);
		}
		
		magnet_anvil = noone;
		lose_anvil();
		
		//squash
		if(anvil_index == -1)
		{
			draw_xs = 0.7;
			draw_ys = 1.3;
		}
		
		if(jump_amp + jump_ampx != 2)
			floating = 1;
		
		
		#region anvil momentum
		
		if(place_meeting(x,y+sign(grav),obj_anvil_h))
		{
			momentum_x = instance_place(x,y+sign(grav),obj_anvil_h).hsp*1.2;
		}
		if(place_meeting(x,y+1,obj_anvil_v))
		{
			momentum_y = instance_place(x,y+1,obj_anvil_v).vsp*0.8;
		}
		
		#endregion
	}
	else if(floating and !float_reset_used)
	{
		audio_stop_sound(sfx_jump_long);
		play_sfx(sfx_jump_cancel);
		float_reset_used = 1;
		vsp *= 0.3;
		//floating = 0;														///////////new
		momentum_x *= 0.3;
		if(instance_exists(obj_orb_message))
		obj_orb_message.list_played_messages[|MESSAGES.float_cancel] = 1;
	}

}

//look up and down
	 if(key_up)   look_cnt =  abs(look_cnt)+1;
else if(key_down) look_cnt = -abs(look_cnt)-1;
else look_cnt = 0;

if(obj_input.jump_with_up and !ground)
	look_cnt = 0;

var _look_dis = obj_camera.view_h/2-50;//camera_get_view_height(view_current)/2-50;

var _mult = 1.5;
if(global.camera_zoom < 1) _mult = 2;

if(y < obj_camera.view_h/2 or y > room_height - obj_camera.view_h/2)
	_look_dis *= _mult;

#region wrokaround

if(room == rm_ravine_roof) _look_dis *= 1.4;
#endregion

//look up
if(look_cnt > look_time)
if(look_inst == noone) 
	look_inst = instance_create_depth(x,y-_look_dis,0,obj_follow)

//look down
if(look_cnt < -look_time)
if(look_inst == noone) 
	look_inst = instance_create_depth(x,y+_look_dis,0,obj_follow)

if(look_cnt == 0)
if(look_inst != noone)
{
	instance_destroy(look_inst);
	look_inst = noone;
}

if(instance_exists(look_inst))
	look_inst.x = x;

}
else hsp = 0;

#endregion
#region movement calculation

var disable_grav = 0;
if(instance_exists(obj_cutscene))
if(turned_precent > 0.2 and !is_capital and obj_cutscene.index != CUTSCENES.kinghood)
	disable_grav = 1;

if(ground<1 and !disable_grav)
	vsp += grav;

//momentum_x 
hsp += momentum_x;
if (ground == 1) momentum_x = approach(momentum_x,ground_fric,0) 
else momentum_x = approach(momentum_x,air_fric,0)

//momentum_y
vsp += momentum_y;
momentum_y = 0;

hsp = clamp(hsp,-hsp_max,hsp_max);
vsp = clamp(vsp,-vsp_max,vsp_max);

//"climb staris"
if(vsp == 0)
{
	var stair = instance_place(x+hsp,y+vsp,obj_solid);						//detect wall as a stair
	if(stair  = noone) stair = instance_place(x+hsp,y+vsp,obj_green);		//detect green as a stair
	if(stair != noone and stair.object_index == obj_green and !stair.frozen) stair = noone;		//deselect green if he is not frozen

	//trigger climbing
	if(stair != noone)
	{
		if(grav_amp > 0 and abs(stair.bbox_top-bbox_bottom)<8)
			y = stair.bbox_top-1;
			
		if(grav_amp < 0 and abs(stair.bbox_bottom-bbox_top)<8)
			y += abs(stair.bbox_bottom-bbox_top+1);
	}
}

//decrease hsp and vsp if collision is met.
collision();

x += hsp;
y += vsp;
	
//"ledge grab"
var _green = instance_place(x,y,obj_green); 
if(_green != noone and !_green.frozen) _green = noone;

while(place_meeting(x,y,obj_solid) or place_meeting(x,y,_green))
{
	if(place_meeting(x,y,obj_wall_block)) break;
	
	x -= sign(hsp);
	if(hsp == 0)
		y -= sign(grav_amp);
}

if(bow)
{
	//push to point
	var pxdest = obj_trigger.x;
	var momx = (pxdest-x)/10;
	
	var curve  = animcurve_get(cur_turnover);
	var channel = animcurve_get_channel(curve,"pull_force");
	var force = animcurve_channel_evaluate(channel,1)*0.3;
	momentum_x = momx*force;
	
	//stick to the ground
	var flor = instance_nearest(x,y,obj_solid);
	y = approach(y,6,flor.bbox_top);
}

#endregion
#region dying

if(killer != noone and !dead)
	event_user(1);

#endregion
#region visuals

if(is_capital) sprite_index = spr_capital;
else sprite_index = spr_player;

//destruction
if(global.flag_power_plant)
{
	draw_xs = approach(draw_xs,0.01,0);
	draw_ys = approach(draw_ys,0.01,0);
	
	if(draw_xs == 0)
	{	
		killer = obj_power_plant.id;
		//var eye = instance_create_depth(x+eye_xoff,y-sprite_height/2+eye_yoff,depth,obj_player_eye);
		//eye.image_xscale = eye_dir;
		//eye.hsp = eye_hsp;
		//eye.vsp = eye_vsp;
		
		//if(is_capital) 
		//	eye.sprite_index = spr_capital_eye;
	}
}
#endregion

///@description 
if(instance_exists(obj_pause)) exit;

//base vars
draw_xs_goal = 1;
draw_ys_goal = 1;
var ground_prev = ground;
ground = place_meeting(x,y+sign(grav),obj_solid) or place_meeting(x,y+sign(grav),obj_wall_capital)

#region state machine

switch(state)
{
	#region normal
	case GREEN_STATES.normal:
		
	frozen = 0;
		
	//move
	hsp = spd*dir;
		
	/// wait while standing on an anvil ///	
	
	//var _anvil = instance_place(x,y+1,obj_anvil);
	//if(_anvil != noone and (_anvil.hsp != 0 or _anvil.vsp != 0))
	//	state = GREEN_STATES.anvil;
	
	//// jump ////
	
	//stuck
	if(x == xprev)
		stuck_alarm++;
	else
		stuck_alarm = 0;
	
	//jumping and turning around
	if(ground)
	{
		
		if(stuck_alarm > 25)
		{
			stuck_alarm = 0;
			dir = -dir;
		}
		if(stuck_alarm > 5)
		{
			jump();
		}
	
		//going off ground
		mask_index = mask_pixel;
		//if(!place_meeting(x+sign(hsp)*32,y+1,obj_solid) and !place_meeting(x+sign(hsp)*32,y+1,obj_wall_capital))
		if(!place_meeting(x+dir*16,y+1,obj_solid) and !place_meeting(x+dir*16,y+1,obj_wall_capital))
			jump();
		
		mask_index = sprite_index;
		
		//spikes
		if(place_meeting(x+hsp,y,obj_hazard))
			jump();
	}
	break;
	#endregion
	#region jump squat
	case GREEN_STATES.jump_squat:
	
	draw_xs_goal = 1.3;
	draw_ys_goal = 0.7;
	
	if(--jump_squat == 0)
	{
		jump_squat = -1;
		
		draw_xs = 0.7;
		draw_ys = 1.3;
		
		momentum_x = 3*dir
		vsp = -jumpforce*jump_amp;
		my_sfx = play_sfx(sfx_jump);
		audio_sound_gain(my_sfx,0.4,0)
		state = GREEN_STATES.normal;
	}
	
	break;
	#endregion
	#region press
	case GREEN_STATES.press:
		
	if(!mouse_check_button(mb_left))
	{
		state = GREEN_STATES.normal;
		global.last_time++;	
	}
	
	frozen = 1;
		
	break;
	#endregion
	#region anvil
	case GREEN_STATES.anvil:
	
	var _anvil = instance_place(x,y+1,obj_anvil);
	if(_anvil == noone or (_anvil.hsp == 0 and _anvil.vsp == 0))
		state = GREEN_STATES.normal;
	
	break;
	#endregion
}

#endregion
xprev = x;
#region vars management

if(instance_exists(obj_orb) and obj_orb.state == ORB_STATES.orange and obj_orb.state_action != JUMPER_STATES.natural)
{
	
	if(place_meeting(x,y+1,obj_orb))
		jump_amp = obj_orb.jump_amp;
		
	else if(place_meeting(x-1,y,obj_orb) or place_meeting(x+1,y,obj_orb))
		jump_ampx = obj_orb.jump_ampx;
	
	else 
	{
		reset_amp();
	}

}
else reset_amp();

#endregion
#region movement

if(!frozen)
{		
	grav = approach(grav,0.007,0.8);
	if(vsp < 0) grav = 0.8;
	
	//squash
	if(!ground_prev and ground)
	{
		draw_xs = 1.3;
		draw_ys = 0.7;
	}
	
	//fall
	var _g = grav;
	if(jump_amp != 1 or jump_ampx != 0) _g = float_grav;
	
	if(!ground) vsp += _g;
	
	//momentum x
	var _fric = ground_fric;
	if(!ground) _fric = air_fric;
	momentum_x = approach(momentum_x,_fric,0);
	hsp += momentum_x;
	
	var _sprev = hsp + vsp
	
	collision_npc()

	//reset float on col
	if(_sprev != hsp + vsp)
	{
		reset_amp();
	}
	
	x += hsp;
	y += vsp;
	
	//loop when stuck inside orb
	if(place_meeting(x,y,obj_orb) and place_meeting(x,y,obj_wall) 
	and obj_orb.state == ORB_STATES.purple and obj_orb.state_action != 0)
	{
		while(place_meeting(x,y,obj_solid))
			y--;
	}
	
	//loop when stuck inside a wall
	if(place_meeting(x,y,obj_pre_solid))
	{
		while(place_meeting(x,y,obj_pre_solid))
			y--;
	}
	
}

#endregion
#region desquash

var s_spd = 0.03;
draw_xs = approach(draw_xs,s_spd,draw_xs_goal);
draw_ys = approach(draw_ys,s_spd,draw_ys_goal);

#endregion
#region die

if(y > room_height+100)	
	instance_destroy();
	
var _haz = instance_place(x,y,obj_hazard);
if(_haz != noone)
{	
	killer = _haz;
	
	//body
	with instance_create_depth(x,y,depth,obj_miner_body)
	{
		eye_index = other.eyeout_index;
		eye_scale = other.eye_scale;
	}
	
	//eye
	with instance_create_depth(x,y,depth,obj_player_eye)
	{
		hsp = other.eye_hsp;
		vsp = other.eye_vsp;
	}
	
	play_sfx(sfx_spikes);
	instance_destroy();
}

eye_hsp = hsp;
eye_vsp = vsp;

if(killer != noone) instance_destroy();

#endregion
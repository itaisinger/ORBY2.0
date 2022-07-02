first = 1;
//input
key_up    = 0;
key_down  = 0;
key_left  = 0;
key_right = 0;
key_jump  = 0;
key_esc   = 0;

//gneral vars
killer = -4;
dead = 0;
room_entrance = -1
is_paused = 0;
has_anvil = 0;
anvil_index = -1;
respawn_at_spawnpoint = 0;
float_reset_used = 0;
follow_active = true;
bow = 0;
i_frames = 0;

//stats
base_spd   = 4;
base_grav  = 0.8;
grav_anvil = 0.9;
float_grav = 0.35;
has_control = 1;
is_king = 0;
is_capital = 0;

//movement vars
vsp = 0;
hsp = 0;
hsp_max = 15;
vsp_max = 30;
ground = 0;
jump_amp_cooldown = 2;

//horizontal
spd = 4
momentum_x = 0;				//momentum for orange orb
ground_fric = 1.6;
jump_ampx = 1;				//jump amp horizontaly
air_fric = 0.3;

//vertical
grav = 0.8
momentum_y = 0;
jumpforce = 12;
jump_amp  = 1;
grav_amp = 1;				//for anvil
hard_grav = -1;				//set this to anything to negate all other grav types.
weight = WEIGHTS.player;
floating = false;			//when true your gravity is lower and you can press jump to cancel vsp;

//visuals
depth = DEPTH.player;
jump_glow_alpha = 0;
eye_xoff = 0;
eye_yoff = 0;
eye_dir  = 1;
sq_off = 0;			//used to draw the eyeout sprite when squashing
draw_xs = 1;		//used as image_xscale, to prevent image_xscale from messing with bbox.
draw_ys = 1;
eye_hsp = 0;		//used to send the eye inst movement vars when dying
eye_vsp = 0;
creating = 0;
float_anim_precent = 1;
float_anim_prev = 0;
crown_y  = -sprite_height/2;
crown_ys = 1;

turned_precent = 0;
draw_eye = 1;

look_inst = noone;
look_cnt  = 0; //count for how many frames you are looking up or down
look_time = 40;

var spawn = instance_find(obj_spawn,0);
if(spawn != -4)
{
	y -= sign(y-spawn.y);
}
 
//reset offset
sprite_set_offset(sprite_index,16,32);
sprite_set_offset(spr_eyeout,7,22);


enum PLAYER_STATES{
	ground,
	jump,
	float,
}

//fuck me
magnet_anvil = noone;

//sound
jump_sound_id = -1;

#region functions

set_jump_amp = function()
{
	jump_ampx = 1;
	jump_amp = obj_orb.jump_amp;
	alarm[0] = jump_amp_cooldown;
}
set_jump_ampx = function()
{
	jump_amp = 1;
	jump_ampx = obj_orb.jump_amp;
	alarm[0] = jump_amp_cooldown;
}

#endregion
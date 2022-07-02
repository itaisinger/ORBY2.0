///@description 
text = "";
//movement
hsp = 0;
vsp = 0;
spd = 3;
grav = 0.8;
ground = 0;
jumpforce = 12;
xprev = x;

//extras
hsp_max = 15;
vsp_max = 30;
float_grav = 0.35;
jump_amp = 1;
momentum_x = 0;				//momentum for orange orb
ground_fric = 1;
jump_ampx = 1;				//jump amp horizontaly
air_fric = 0.05;

//visuals
eye_xoff = 0;
eye_yoff = 0;
eye_dir  = 1;
sq_off   = 0;
depth = DEPTH.player+1
eye_a = 0;
eyeout_index = irandom(sprite_get_number(spr_miner_eyeout))
eye_scale = random_range(0.9,1.2);

draw_xs = 1;
draw_ys = 1;
draw_xs_goal = 1;
draw_ys_goal = 1;

//sound
my_sfx = 0;

//behaviour
state = 0;
dir = 0;
stuck_alarm = -5;
killer = noone;
jump_squat_max = 3;

enum GREEN_STATES{
	normal,
	jump_squat,
	press,
	anvil, //wait while standing on a moving anvil
}

//green
frozen = 0;
is_made = 1;

function jump(){
	hsp = 0;
	state = GREEN_STATES.jump_squat;
	jump_squat = jump_squat_max;
	momentum_x = 4*hsp;
}
function reset_amp(){
	jump_ampx = 0;
	jump_amp = 1;
}
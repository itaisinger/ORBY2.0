///@description 
//movement
hsp = 0;
vsp = 0;
spd = 3;
grav = 0.8;
ground = 0;
jumpforce = 12;

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
my_orb = instance_create_depth(x,y,depth,obj_orb_miner);
my_orb.parent = self;
alarm[0] = -1;
dir = 0;			//set this to a value to prechoose what direction this miner will go.
stage = 0;

enum MINERS{
	created,
	spawn,
	multijump,
	fall,
	normal,
	menu,
}

min_y = 99999;

function jump(){
	vsp = -jumpforce;
	my_sfx = play_sfx(sfx_jump);	
	audio_sound_gain(my_sfx,0.4,0)
}
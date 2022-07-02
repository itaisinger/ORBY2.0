chosen = 0;
///@description 
//movement
hsp = 0;
vsp = 0;
spd = 3;
grav = 0.8;
ground = 0;
momentum_x = 0;
momentum_y = 0;
air_fric = 0.2;
ground_fric = 1;

//visuals
eye_xoff = 0;
eye_yoff = 0;
eye_dir  = 1;
sq_off   = 0;
depth = DEPTH.player+1
draw_xs = 0;
draw_ys = 0;

draw_xs = 1;
draw_ys = 1;
draw_xs_goal = 1;
draw_ys_goal = 1;

//behaviour
walk_cd = 0;	//wait before the next walking
walk_dis = 0;	//walk for how long
walk_spd = 0;
my_anvil = noone;
onscreen = 0;
state = 0;
run_dir = 0;

enum CAPITAL_STATES{
	natural,
	run,
	shock,
	bow,
	bow_king,
	anvil,
	despawn,
}

is_made = 0;
randomize()
fright_id = -1;
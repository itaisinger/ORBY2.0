///@description 
hsp = 0;
vsp = 0;
grav = 0.6;

ground_fric = 0.8;
air_fric = 0.05;

depth = DEPTH.player;
anchor = true;

draw_off = 0;
is_made = 0;
checked = 0;

follow_active = 0;
eyeout_spr = spr_eyeout

min_ys = 0;

if(obj_player.dead)
	play_sfx(sfx_squash);
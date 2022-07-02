enum TRANS_STATES{
	off,
	goto,
	restart,
	load,
	load_prev,
	load_checkpoint,
	intro,
	menu,
	ending,
	goto_credits,
}

state = TRANS_STATES.intro;
state_prev = state;
precent = 1;
target_room  = room;
target_enter = 0;
draw_color = c_black;
spd_var = 1;
depth = DEPTH.trans;

if(instance_exists(obj_orb))		   draw_color = get_colors(obj_orb.current_color);
else if(instance_exists(obj_menu_orb)) draw_color = get_colors(obj_menu_orb.color);
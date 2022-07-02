///@description 

state_action = 0;
draw_mode = DRAW_MODES.natural;
is_anchored = 0;

if(platform_inst != noone)
	instance_destroy(platform_inst);
	
	
//switch out of menu
if(state == ORB_STATES.menu and room != rm_menu)
{
	state = ORB_STATES.black;
}

platform_current = platform_max;
pink_remain = pink_max;
green_remain = green_max;
light_remain = light_max;

ds_list_clear(list_lamps);

//just a thing
if(room == rm_dark_7) state = ORB_STATES.black;

//testroom
if(room == rm_test)
{
	unlock_list = ds_list_create()
	for(var i=0; i<ORB_STATES.black; i++)
		unlock_list[|i] = i;
}

///@desc transition
///@arg0mode
///@arg1room_target
///@arg2enterance_trarget
function transition() {

	with(obj_transition)
	{
		//sfx
		if(state == TRANS_STATES.off)
			play_sfx(sfx_outro);
		
		if(argument[0] == 2)
			show_debug_message("restarting")
		
		state = argument[0];
	
		if(argument_count > 1) 
		{
			target_room = argument[1];
			target_enter = argument[2];
		}	
	
		//find color
		if(instance_exists(obj_orb))		   draw_color = get_colors(obj_orb.current_color);
		else if(instance_exists(obj_menu_orb)) draw_color = get_colors(obj_menu_orb.color);
	}


}

///@description orange
current_color = COLORS.orange;

if(instance_exists(obj_player))
{
	//obj_player.jump_ampx = 1;
	//obj_player.jump_amp = 1;
}

switch(state_action)
{
	case JUMPER_STATES.natural:
	
	if(key_1)
	{
		play_sfx(sfx_place_b);
		rec_w = radius*1.5;
		rec_h = radius*1.5;
		var plat_h = 10;
		var plat_w = 32;
		mask_index = mask_pixel;
		
		var snap = collision_rectangle(x-rec_w/2,y-rec_h/1, x+rec_w/2,y+rec_h/1,obj_pre_solid,0,1);
		if(snap != noone)
		{
			is_anchored = 1;
			draw_mode = DRAW_MODES.rec;
			
			var right_dis = max(15,abs(snap.bbox_right-x));
			var left_dis  = max(15,abs(snap.bbox_left-x));
			var top_dis   = abs(snap.bbox_top-y)/2;
			
			//snap to top
			if((top_dis < left_dis and top_dis < right_dis) and !place_meeting(x,snap.bbox_top-1,obj_pre_solid))
			{
				state_action = JUMPER_STATES.flor;
				jump_dir = 1;
				rec_h = plat_h;
				rec_w = plat_w;
				y = snap.bbox_top + rec_h/2;
			}
			//snap to side
			else if(!place_meeting(snap.bbox_right+1,y,obj_pre_solid) or !place_meeting(snap.bbox_left-1,y,obj_pre_solid))
			{
				state_action = JUMPER_STATES.wall;
				jump_dir = 1;
				rec_h = plat_w;
				rec_w = plat_h;
				
				//determine if snap left or right
				
				//snap left
				if(left_dis < right_dis)
					x = snap.bbox_left  + rec_w/2;
				//snap right
				else
					x = snap.bbox_right - rec_w/2;
			}
			
			//cancel if no bbox to snap to
			else
			{
				state_action = JUMPER_STATES.natural;
				draw_mode = DRAW_MODES.natural;
				is_anchored = 0;
				error_frames = 10;
			}
			
			//snap to edges horizontally
			if(state_action == JUMPER_STATES.flor)
			{
				while(x + rec_w/2 > snap.bbox_right) x--
				while(x - rec_w/2 < snap.bbox_left)  x++
			}
			
			//snap to edges vertically
			if(state_action == JUMPER_STATES.wall)
			{
				while(y + rec_h/2 > snap.bbox_bottom) y--
				while(y - rec_h/2 < snap.bbox_top)	  y++
			}
		}
		else error_frames = 10;
		
		mask_index = mask_orb;
	}
	
	break;
	///////////////
	case JUMPER_STATES.flor:
	
	//return to netural
	if(key_1)
	{
		play_sfx(sfx_deplace_b);
		state_action = JUMPER_STATES.natural;
		draw_mode = DRAW_MODES.natural;
		is_anchored = 0;
	}
	
	break;
	////////////////
	case JUMPER_STATES.wall:

	//return to netural
	if(key_1)
	{
		play_sfx(sfx_deplace_b);
		state_action = JUMPER_STATES.natural;
		draw_mode = DRAW_MODES.natural;
		is_anchored = 0;
	}
	
	break;
}

///@description purple
current_color = COLORS.purple;

switch(state_action)
{
	case PLATFORM_STATES.natural:
	
	if(key_1)
	{
		if(platform_current > 0)
		{
			//update relevent vars
			platform_current--;
			state_action = PLATFORM_STATES.plaform;
			draw_mode = DRAW_MODES.rec;
			play_sfx(sfx_place);
			
			rec_w = 64;
			rec_h = 12;
			
			is_anchored = 1;
			
			//check for player collision
			var col = collision_rectangle(x-rec_w/2,y-rec_h/2, x+rec_w/2,y+rec_h/2,obj_player,0,1);
			if(col != noone)
			{
				if(obj_player.grav_amp > 0) y = obj_player.bbox_bottom + rec_h/2;
				if(obj_player.grav_amp < 0) y = obj_player.bbox_top    - rec_h/2;
			}
			//check for nerby wall to snap to			
			var snap = collision_rectangle(x-rec_w/2,y-rec_h/2, x+rec_w/2,y+rec_h/2,obj_solid,0,1);
			var snap_to = 0;
			
			if(snap != noone)
			{
				mask_index = mask_pixel;
				
				//snap to top, but only if the wall has no wall above it.
				if(snap.bbox_top > y-rec_h*2 and snap.bbox_top < y+rec_h*2)
				{
					if(!place_meeting(snap.x,snap.bbox_top-1,obj_wall))
					{
						y = snap.bbox_top + rec_h/2;
						snap_to = -1;
					}
				}
				 
				//snap to bottom
				else if(snap.bbox_bottom > y-rec_h*2 and snap.bbox_bottom < y+rec_h*2)
				{
					if(!place_meeting(snap.x,snap.bbox_bottom+1,obj_wall))
					{
						y = snap.bbox_bottom - rec_h/2;
						snap_to = 1;
					}
				}
				
				//snap to left
				if(snap.bbox_left > x-rec_w/2 and snap.bbox_left < x+rec_w/2)
				{
					rec_w *= 1.5;
					x = snap.bbox_left - rec_w/2;
				}
				
				//snap to right
				else if(snap.bbox_right > x-rec_w/2 and snap.bbox_right < x+rec_w/2)
				{
					rec_w *= 1.5;
					x = snap.bbox_right + rec_w/2;
				}
				
				
				mask_index = mask_orb;
			}
			
			//create the wall platform
			platform_inst = instance_create_depth(0,0,depth+1,obj_wall);
			with(platform_inst)
			{
				image_xscale = other.rec_w/sprite_width;
				image_yscale = other.rec_h/sprite_height;
				
				x = other.x - sprite_width/2;
				y = other.y - sprite_height/2;	
				
				is_made = true;
				image_alpha = 0;
			}
			
			//snap even more
			if(snap == 1) platform_inst.y += snap.bbox_bottom - bbox_bottom;
			if(snap == -1) platform_inst.y += snap.bbox_top - bbox_top;
		}
		else
		{
			play_sfx(sfx_error)
			error_frames = 10;
		}
	}
	
	if(platform_current <= 0) disabled = true;
	else disabled = false;
	
	break;
	///////////////
	case PLATFORM_STATES.plaform:
	
	if(key_1)
	{
		play_sfx(sfx_deplace);
		state_action = PLATFORM_STATES.natural;
		draw_mode = DRAW_MODES.natural;
		is_anchored = 0;
		instance_destroy(platform_inst);
	}
	
	break;
}

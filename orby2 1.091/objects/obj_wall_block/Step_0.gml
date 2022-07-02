///@description 
if(instance_exists(obj_pause)) exit;

#region exit to not play animation while offscreen
if(room != rm_blue_finale)
{
	off = 0;
	if(bbox_right  > obj_camera.x+camera_get_view_width(view_current)) off = true;
	if(bbox_top    > obj_camera.y+camera_get_view_height(view_current)) off = true;
	if(bbox_left   < obj_camera.x) off = true;
	if(bbox_bottom < obj_camera.y) off = true;

	if(off and state != WALL_STATES.broken)
	{
		exit;
	}
	
	//for when a fake wall is abstructing
	var wall = instance_place(x,y,obj_wall_fake);
	if(wall != noone)
		if(wall.image_alpha == 1)
			exit;

}
#endregion
switch(state)
{
	case WALL_STATES.natural:
		sprite_index = spr_wall_old;
		mask_index = sprite_index;
		if(obj_game.list_pressed_keys[|index])
		{
			state = WALL_STATES.breaking;
			effect_grid = instance_create_depth(x,y,depth-1,obj_effect)
			with(effect_grid)
			{
				sprite_index = other.grid_effects[other.index];
				loop = 0;
				destroy_at_end = 0;
			}
		}
		break;
	////////////////////////	
	case WALL_STATES.breaking:
		sprite_index = spr_wall_old;
		if(effect_grid.image_index == effect_grid.image_number-1)
		{
			state = WALL_STATES.breaking2;
			effect_wave = instance_create_depth(x,y,depth-1,obj_effect)
		
			with (effect_wave)
			{
				sprite_index = spr_wall_break_over
				loop = 0;
				destroy_at_end = 1;
			}
		}
		break;
	///////////////////////////////
	case WALL_STATES.breaking2:
		//destroy grid
		sprite_index = spr_wall_old;
		if(instance_exists(effect_wave))
		if(floor(effect_wave.image_index) == floor(effect_wave.image_number/2))
		{
			state = WALL_STATES.breaking3;
			instance_destroy(effect_grid);
			
			//destroy all surounding spikes
			if(destroy_spikes)
			{
				while(place_meeting(x-1,y,obj_spikes))
					instance_destroy(instance_place(x-1,y,obj_spikes));
				
				while(place_meeting(x+1,y,obj_spikes))
					instance_destroy(instance_place(x+1,y,obj_spikes));
				
				while(place_meeting(x,y-1,obj_spikes))
					instance_destroy(instance_place(x,y-1,obj_spikes));
				
				while(place_meeting(x,y+1,obj_spikes))
					instance_destroy(instance_place(x,y+1,obj_spikes));
			}
		}
		
		break;
	/////////////////////////////////////
	case WALL_STATES.breaking3:
		
		//proceed to the next phase
		if(!instance_exists(effect_wave))
		{
			state = WALL_STATES.broken;
		}
		sprite_index = -1;
		mask_index   = -1;
		break;
	/////////////////////////////////////
	case WALL_STATES.broken:	
		sprite_index = -1;
		mask_index = -1;
		break;
}
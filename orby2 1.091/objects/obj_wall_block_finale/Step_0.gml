///@description 
#region exit to not play animation while offscreen

var _exit = 0;
if(alarm[0] > 0 or !onscreen) _exit = 1;

onscreen = 1;

if(_exit) exit;

#endregion

switch(state)
{
	case WALL_STATES.natural:
		sprite_index = spr_wall_block_finale;
		mask_index = sprite_index;
		if(ds_list_size(obj_game.list_placed_anvils) == 4 and obj_player.turned_precent > 0) //and cutscene has started
		{
			state = WALL_STATES.breaking;
			effect_grid = instance_create_depth(x,y,depth-1,obj_effect)
			with(effect_grid)
			{
				image_xscale = other.image_xscale;
				image_yscale = other.image_yscale;
				sprite_index = spr_wall_break6;
				loop = 0;
				destroy_at_end = 0;
			}
		}
		break;
	////////////////////////	
	case WALL_STATES.breaking:
		sprite_index = spr_wall_block_finale;
		if(effect_grid.image_index == effect_grid.image_number-1)
		{
			state = WALL_STATES.breaking2;
			effect_wave = instance_create_depth(x,y,depth-1,obj_effect)
		
			with (effect_wave)
			{
				image_xscale = other.image_xscale;
				image_yscale = other.image_yscale;
				sprite_index = spr_wall_break_over
				image_index = 16;
				loop = 0;
				destroy_at_end = 1;
			}
		}
		break;
	///////////////////////////////
	case WALL_STATES.breaking2:
		//destroy grid
		sprite_index = spr_wall_block_finale;
		if(instance_exists(effect_wave))
		if(floor(effect_wave.image_index) == floor(effect_wave.image_number/2))
		{
			state = WALL_STATES.breaking3;
			
			instance_destroy(effect_grid);
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
		//if(instance_exists(follow_inst)) instance_destroy(follow_inst);
		sprite_index = -1;
		mask_index = -1;
		break;
}
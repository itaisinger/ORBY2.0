///@desc green
current_color = COLORS.green;
disabled = green_remain == 0 and !instance_exists(obj_green)

/*/
when pressing m1
	if clicking on a miner, flip its direction
	else, create a miner
	
/*/

//a few things here need some rework if a few miners can be created at once
if(key_1)
{
	if(disabled)
	{
		play_sfx(sfx_error)
		error_frames = 20;
	}
	else
	{
		//check for miner
		var _xs = image_xscale;
		var _mi = mask_index;
		image_xscale = 5;
		image_yscale = 5;
		mask_index = spr_miner;
		var _miner = instance_place(x,y,obj_green);
		
		//switch miner dir
		if(_miner != noone)
		{
			//switch miner direction
			_miner.dir *= -1;
			
			//trigger freeze
			_miner.state = GREEN_STATES.press;
			with(_miner) vsp = max(vsp/3,vsp);
		}
		else
		{
			image_xscale = 1;
			image_yscale = 1;
			mask_index = spr_miner;
			if(place_meeting(x,y,obj_solid) or place_meeting(x,y,obj_wall_capital))
			{
				play_sfx(sfx_error)
				error_frames = 20;
			}
			//create miner
			else if(green_remain > 0)
			{
				//create miner
				my_miner = instance_create_depth(x,y,0,obj_green);
				my_miner.dir = 1;
			
				green_remain--;
			}
			//error
			else
			{
				play_sfx(sfx_error)
				error_frames = 20;
			}
			
		}
		
		image_xscale = _xs;
		image_yscale = _xs;
		mask_index = _mi;
	}
}
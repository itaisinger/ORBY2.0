///@description 


if(image_angle = 0 and image_xscale = 1 and image_yscale = 1)
{
	
	if(instagrav)
	{
		instagrav--;
		while(!place_meeting(x,y+1,obj_wall))
		{
			y++;
			
			if(bbox_top > room_height)
			{
				instance_destroy();
				exit;
			}
		}
	}

	vsp += 0.8;
	collision_spikes();
	y += vsp;
}

depth = DEPTH.spike;
///@description pink
current_color = COLORS.pink;

//vars
pink_remain = max(0,pink_max - instance_number(obj_pink_spikes));
disabled = (pink_remain == 0)

//action
if(key_1)
{
	/*/
	when mouse1 pressed
	check for pink
		if found, destroy it.
		else, if disabled, play sfx.
		else look for spikes.
			if found, create the pink
	/*/
	
	//search for pink
	var _pink = instance_place(x,y,obj_pink_spikes);
		
		if(_pink != noone){
			instance_destroy(_pink);
			play_sfx(sfx_pink_deplace);
	}
	//disabled
	else if(disabled)
	{	
		play_sfx(sfx_error)
		error_frames = 20;
	}
	//try to create pink
	else
	{
		//search for spikes
		var _l = ds_list_create();
		image_xscale = 2.4; 
		image_yscale = 2.4;
		instance_place_list(x,y,obj_hazard,_l,0);
		image_xscale = 1;
		image_yscale = 1;
		
		//spikes found
		if(ds_list_size(_l) > 0)
		{
			#region create the pink
			/*/
			find out which spike is the closest
			create the pink
			align to spikes angle and orb pos
			check for spikes at edges. if no spikes, align.
			check for spikes at the other side. if none, delete double.
			/*/
			
			//loop thourgh the spikes to determine which one is the closest
			var _min_dis = 64,_min_i = 0, _dis;
			
			if(ds_list_size(_l) > 1)
			{
				for(var i=0; i < ds_list_size(_l); i++)
				{
					_dis = col_distance_to_object(_l[|i]);	
					if(_dis < _min_dis)
					{
						_min_dis = _dis;
						_min_i = i;
					}
				}
			}

			var _pink = instance_create_depth(0,0,0,obj_pink_spikes);
			_pink.attach(_l[|_min_i]);
			play_sfx(sfx_pink_place_nock);
			
			#endregion
		
		}
		//play error
		else{ 	
		play_sfx(sfx_error)
		error_frames = 20;
		}
	}
}


///@description 
var l = obj_game.map_pressed_keys_by_room[? string(room)];
if(l != undefined)
{
	if(l[|index])
	{
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
			
		sprite_index = -1;
		mask_index = -1;
		state = WALL_STATES.broken;
	}
}
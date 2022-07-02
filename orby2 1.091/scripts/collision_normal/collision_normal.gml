function collision_normal() {

	//horizontal
	if(place_meeting(x+hsp,y,obj_solid) or place_meeting(x+hsp,y,obj_hazard))
	{
		while(hsp != 0)
		{
			var move = 0;
		
			if(!place_meeting(x+sign(hsp),y,obj_solid))
			     move = 1;
			else hsp = 0;
		
			if(!place_meeting(x+sign(hsp),y,obj_hazard))
				move = 1;
		
			if(move) x += sign(hsp);
			move = 0;
		}
	}

	//vertical
	if(place_meeting(x,y+vsp,obj_solid) or place_meeting(x,y+vsp,obj_hazard))
	{
		while(vsp != 0)
		{
			var move = 0;
		
			if(!place_meeting(x,y+sign(vsp),obj_solid))
			     move = 1;
			else vsp = 0;
		
			if(!place_meeting(x,y+sign(vsp),obj_hazard))
				move = 1;
		
			if(move) y += sign(vsp);
			move = 0;
		
			if(bbox_top > room_height)
			{
				instance_destroy();
				exit;
			}
		}
	}


}

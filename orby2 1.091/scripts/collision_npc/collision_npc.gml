function collision_npc() {
	
	//////horizontal
	
	//pink spikes
	var _pink = instance_place(x+hsp,y,obj_pink_spikes)
	if(_pink != noone)
	{
		momentum_x = 16*-sign(hsp);
		vsp = -jumpforce*0.8;
		hsp = 0;
		
		play_sfx(_pink.get_sfx(hsp));
		instance_destroy(_pink)
	} 
	
	//capital walls
	if(place_meeting(x+hsp,y,obj_wall_capital))
	{
		while(!place_meeting(x+sign(hsp),y,obj_wall_capital))
			x += sign(hsp);
			
		hsp = 0;
	}
	
	//walls
	if(place_meeting(x+hsp,y,obj_solid))
	{
		while(!place_meeting(x+sign(hsp),y,obj_solid))
		{
			x += sign(hsp);
		}
		hsp = 0;
	}


	////////vertical
	
	//pink spikes
	var _pink = instance_place(x,y+vsp,obj_pink_spikes)
	if(_pink != noone)
	{
		vsp = -(vsp*1.2)
		play_sfx(_pink.get_sfx(vsp));
		instance_destroy(_pink)
	}
	
	//capital walls
	if(place_meeting(x,y+vsp,obj_wall_capital))
	{
		while(!place_meeting(x,y+sign(vsp),obj_wall_capital))
			y += sign(vsp);
			
		vsp = 0;
	}
	
	//walls
	if(place_meeting(x,y+vsp,obj_solid))
	{
		while(!place_meeting(x,y+sign(vsp),obj_solid))
		{
			y += sign(vsp);
		}
		vsp = 0;
	}


}

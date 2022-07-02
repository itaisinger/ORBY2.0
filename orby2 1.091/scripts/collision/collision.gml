function collision() {

	/////////////horizontal
	
	var _hspprev = hsp;
	
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
	
	//frozen miner
	var _miner = instance_place(x+hsp,y,obj_green)
	if(_miner != noone and _miner.frozen)
	{
		while(!place_meeting(x+sign(hsp),y,_miner))
			x += sign(hsp);
		
		hsp = 0;
	}
	
	//capital walls
	if(!is_capital and place_meeting(x+hsp,y,obj_wall_capital))
	{
		while(!place_meeting(x+sign(hsp),y,obj_wall_capital))
			x += sign(hsp);
			
		hsp = 0;
	}
	
	//walls and hazards
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
			else if(!i_frames) //colliding with a hazard (spikes)
			{
				killer = instance_place(x+sign(hsp),y,obj_hazard);;
				eye_hsp = hsp;
				hsp = 0;
			
				if(eye_vsp == 0) eye_vsp = vsp;
			}
		
			if(move) x += sign(hsp);
			move = 0;
		}
	}

	//reset momentum_x
	if(_hspprev != hsp) and (floating and momentum_x != 0)
	{
		if(!audio_is_playing(sfx_land))
			play_sfx(sfx_bump);
		audio_stop_sound(sfx_jump_long);
		floating = 0;
		momentum_x = 0;
	}

	///////////vertical
	
	var _vspprev = vsp;
	
	//pink spikes
	var _pink = instance_place(x,y+vsp,obj_pink_spikes)
	if(_pink != noone)
	{
		vsp = -(vsp*1.2)
		play_sfx(_pink.get_sfx(vsp));
		instance_destroy(_pink)
	}
	
	//frozen miner
	var _miner = instance_place(x,y+vsp,obj_green)
	if(_miner != noone and _miner.frozen)
	{
		while(!place_meeting(x,y+sign(vsp),_miner))
			y += sign(vsp);
			
		vsp = 0;
	}
	
	//capital walls
	if(!is_capital and place_meeting(x,y+vsp,obj_wall_capital))
	{
		while(!place_meeting(x,y+sign(vsp),obj_wall_capital))
			y += sign(vsp);
			
		vsp = 0;
	}
	
	//walls and hazards
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
			else if(!i_frames)
			{	
				//trigger death	
				killer = instance_place(x,y+sign(vsp),obj_hazard);
				eye_vsp = vsp;
				vsp = 0;
			
				if(eye_hsp == 0) eye_hsp = hsp;
			}
		
			if(move) y += sign(vsp);
			move = 0;
		}
	}
	
	if(vsp != _vspprev) and (floating)
	{
		if(!audio_is_playing(sfx_land))
			play_sfx(sfx_bump);
		audio_stop_sound(sfx_jump_long);
		floating = 0;
	}


}

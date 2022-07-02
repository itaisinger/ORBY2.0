///@description 
if(instance_exists(obj_pause)) exit;

#region movement

//movement calculation
if(!place_meeting(x+sign(grav),y,obj_wall))
{
	xforce = grav*weight;
	var me = self;
	
	if(place_meeting(x-sign(obj_player.grav),y,obj_player))
				me.xforce -= sign(obj_player.grav)*obj_player.weight;
	
	//in case of head on horizontal collision, send my xforce forwards. also accounts for player.
	var o_anvil = instance_place(x+sign(grav),y,obj_anvil_h);
	while(o_anvil != noone)
	{
		with(o_anvil)
		{
			me.xforce += grav*weight;
			o_anvil = instance_place(x+sign(me.grav),y,obj_anvil_h);
			
			if(place_meeting(x-sign(obj_player.grav),y,obj_player))
				me.xforce -= sign(obj_player.grav)*obj_player.weight;
		}
	}
	
	hsp += xforce;
}

//collisions


//player body collision, to slowly squash him.
if(place_meeting(x+hsp,y,obj_player_dead))
{
	var body = instance_place(x+hsp,y,obj_player_dead);
	if(body.object_index == obj_player_dead_squashed_h)
	{
		//var new_b = instance_create_depth(body.x,body.y,body.depth,obj_player_dead_squashed_h);
		//new_b.killer = self;
		//instance_destroy(body);
		
		while(!place_meeting(x+sign(hsp),y,obj_player_dead))
		x += sign(hsp);
	
		hsp *= 0.2;
	}	
}
//solid collision
else if(place_meeting(x+hsp,y,obj_pre_solid))
{
	while(!place_meeting(x+sign(hsp),y,obj_pre_solid))
		x += sign(hsp);
	hsp = 0;
}
//anvil pickup collision
else if(place_meeting(x+hsp,y,obj_anvil_pickup))
{
	while(!place_meeting(x+sign(hsp),y,obj_anvil_pickup))
		x += sign(hsp);
	hsp = 0;
}
//player with anvil collision
else if(place_meeting(x+hsp,y,obj_player) and obj_player.anvil_index != -1)
{
	while(!place_meeting(x+sign(hsp),y,obj_player))
		x += sign(hsp);
	hsp = 0;
}
else x += hsp;

//push player
if(obj_player.killer == noone)
if(place_meeting(x+hsp,y,obj_player))
{
	if(obj_player.anvil_index == -1)
	{
		with(obj_player)
		{
			var _killer = instance_place(x,y+other.vsp+sign(other.vsp),obj_solid);
			
			if(_killer != noone and _killer != other.id)				//theres a wall and either:
			and(_killer.object_index != obj_wall_capital or					//the wall normal
			(_killer.object_index == obj_wall_capital and !is_capital))		//the wall is capital but im too
			{
				x += sign(other.hsp);
			
				while(!place_meeting(x+sign(other.hsp),y,obj_pre_solid))
					x += sign(other.hsp);
				
				killer = other;
				event_user(1);
			}
			else x += other.hsp;
		}
	}else
	{
		while(!place_meeting(x+sign(hsp),y,obj_player)) x += sign(hsp);
		
		hsp = 0;
	}
}

//move player as a platform
if(hsp != 0 and instance_exists(obj_player))
if(place_meeting(x,y-sign(obj_player.grav),obj_player))
{
	with(obj_player)
	{
		hsp = other.hsp;
		collision();
		x += hsp;
	}
}


//move green as a platform
if(hsp != 0 and instance_exists(obj_green))
if(place_meeting(x,y-sign(obj_green.grav),obj_green))
{
	with(obj_green)
	{
		hsp = other.hsp;
		collision_npc();
		x += hsp;
	}
}

#endregion

ground = place_meeting(x+sign(grav),y,obj_pre_solid) or place_meeting(x+sign(grav),y,obj_anvil);
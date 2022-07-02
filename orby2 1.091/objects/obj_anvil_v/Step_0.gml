///@description 
if(instance_exists(obj_pause)) exit;

#region vertical movement

//vertical movement calculation
if(!place_meeting(x,y+sign(grav),obj_wall))
{
	yforce = grav*weight;
	var me = self;
	
	if(place_meeting(x,y-sign(obj_player.grav),obj_player))
				me.yforce -= sign(obj_player.grav)*obj_player.weight;
	
	//in case of head on vertical collision, send my yforce upwards. also accounts for player.
	var o_anvil = instance_place(x,y+sign(grav),obj_anvil_v);
	while(o_anvil != noone)
	{
		with(o_anvil)
		{
			me.yforce += grav*weight;
			o_anvil = instance_place(x,y+sign(me.grav),obj_anvil_v);
			
			if(place_meeting(x,y-sign(obj_player.grav),obj_player))
				me.yforce -= sign(obj_player.grav)*obj_player.weight;
		}
	}
	
	vsp += yforce;
}

//collisions

//player body collision, to slowly squash him.
if(place_meeting(x,y+vsp,obj_player_dead))
{
	var body = instance_place(x,y+vsp,obj_player_dead);
	if(body.object_index != obj_player_dead_squashed_v)
	{
		var new_b = instance_create_depth(body.x,body.y,body.depth,obj_player_dead_squashed_v);
		new_b.killer = self;
		instance_destroy(body);
	}
	
	while(!place_meeting(x,y+sign(vsp),obj_player_dead))
		y += sign(grav);
	
	//vsp *= 0.2;
	vsp = 0;
	ground = true;
}
//dead body collision, turn him into a squashed one.
if(place_meeting(x,y+vsp,obj_body))
{
	var body = instance_place(x,y+vsp,obj_body);
	var new_b = instance_create_depth(body.x,body.y,body.depth,obj_player_dead_squashed_v);
	new_b.killer = self;
	new_b.sprite_index = body.sprite_index;
	new_b.eyeout_spr = body.eyeout_spr;
	instance_destroy(body);
	
	while(!place_meeting(x,y+sign(vsp),obj_player_dead))
		y += sign(vsp);
	
	vsp *= 0.2;
}
//solid collision
else if(place_meeting(x,y+vsp,obj_pre_solid))
{
	while(!place_meeting(x,y+sign(vsp),obj_pre_solid))
		y += sign(vsp);
	vsp = 0;
}
//anvil pickup collision
else if(place_meeting(x,y+vsp,obj_anvil_pickup))
{
	while(!place_meeting(x,y+sign(vsp),obj_anvil_pickup))
		y += sign(vsp);
	vsp = 0;
}
//player with anvil collision
else if(place_meeting(x,y+vsp,obj_player) and obj_player.anvil_index != -1)
{
	while(!place_meeting(x,y+sign(vsp),obj_player))
		y += sign(vsp);
	vsp = 0;
}
else y += vsp;


//move player
if(obj_player.killer == noone)
if(place_meeting(x,y+vsp,obj_player))
{
	if(obj_player.anvil_index == -1)
	{
		//kill player
		with(obj_player)
		{
			//wall
			var _killer = instance_place(x,y+other.vsp+sign(other.vsp),obj_solid);
			
			if(_killer != noone and _killer != other.id)				//theres a wall and either:
			and(_killer.object_index != obj_wall_capital or					//the wall normal
			(_killer.object_index == obj_wall_capital and !is_capital))		//the wall is capital but im too
			{
				y += sign(other.vsp);
				
				while(!place_meeting(x,y+sign(other.vsp),obj_solid))
					y += sign(other.vsp);
				
				killer = other;
				event_user(1);
			}
			else y += other.vsp;
		}
	}
	else
	{
		while(!place_meeting(x,y+sign(vsp),obj_player))
			y += sign(vsp);
			
		vsp = 0;
	}
}

#endregion

ground = place_meeting(x,y+sign(grav),obj_pre_solid) or place_meeting(x,y+sign(grav),obj_anvil);
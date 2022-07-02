///@description artificial room start (called from obj game)
#region find entrance
if(room_entrance != -1)
{
	//find entrance
	var ent = noone;
	for(var i=0; i < instance_number(obj_entrance); i++;)
	{
		if(instance_find(obj_entrance,i).index == room_entrance)
			ent = instance_find(obj_entrance,i);
	}

	//teleport to the entrance
	if(ent != noone)
	{
		x = ent.x;
		y = ent.y;
		x += ent.bbox_right-bbox_right;
		y += ent.bbox_bottom-bbox_bottom;
		
		if(anvil_index == -1)
		{
			momentum_x = ent.momentum_x;
			momentum_y = ent.momentum_y;
			vsp = 0;
			hsp = 0;
		}
		
		if(instance_exists(obj_orb))
		{
			obj_orb.x = x;
			obj_orb.y = y;
		}
		
		obj_camera.x = x - camera_get_view_width(view_current)/2;
		obj_camera.y = y - camera_get_view_height(view_current)/2;
	}
	else
	{
		show_message("no entrance found");
		x = 0;
		y = 0;
	}
}
#endregion
#region spawn at spawpoint

if(instance_exists(obj_spawn) and respawn_at_spawnpoint)
{
	if(instance_find(obj_spawn,0).state != SPAWN_STATES.off)
	{
		//the player and obj_game are created before the obj_spawn.
		//so the player is placed at the spawn before it moved from 0,0.
		draw_xs = 0;
		draw_ys = 0;
		ground = 1;
		creating = 1;
		
		if(obj_spawn.y != 0)
		{
			y = obj_spawn.y;
			x = obj_spawn.x;
		}
	}
}

respawn_at_spawnpoint = 0;
killer = -4;

#endregion
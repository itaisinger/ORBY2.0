///@description 
if(instance_exists(obj_pause)) exit;

depth = DEPTH.anvil;
#region movement

ground = place_meeting(x,y+sign(grav_amp),obj_solid)

if(ground) hsp = approach(hsp,ground_fric,0);
else	   hsp = approach(hsp,air_fric,0);

if(!ground)
{
	vsp += grav*grav_amp;
}

collision_npc();

x += hsp;
y += vsp;

#endregion
#region pickup

image_xscale = 1.1;
image_yscale = 1.1;

if(instance_exists(obj_player))
if(obj_player.anvil_index == -1 and place_meeting(x,y,obj_player) and !obj_player.dead)
{
	//deplace myself from the button
	if(placed)
	{
		placed = false;
		var pos = ds_list_find_index(obj_game.list_placed_anvils,creation_num)
		if(pos != -1)
		{
			ds_list_delete(obj_game.list_placed_anvils,pos);
			ds_list_delete(obj_game.list_placed_anvils_x,pos);
		}
		else show_debug_message("tried the delete a non existing anvil from the list");
	}
	spd += 0.5;
	x = approach(x,spd,obj_player.x)
	y = approach(y,spd,obj_player.y)
	
	if(abs(obj_player.x-x) < 5 and abs(obj_player.y-y) < 5)
	{
		obj_player.anvil_index = creation_num;
		obj_player.grav_amp = grav_amp;
		play_sfx(sfx_anvil_pickup);
		instance_destroy();
	}
}
else spd = approach(spd,0.2,4);

image_xscale = 1;
image_yscale = 1;

#endregion
#region placed

if(placed)
{
	y = obj_large_key.bbox_top-1;	
}

#endregion
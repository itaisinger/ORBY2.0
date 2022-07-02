///@description 
if(instance_exists(obj_pause)) exit;

#region check direction on the first frame

if(1)
{
	checked = 1;
	if(killer.grav < 0)
	{
		//try to avoid clipping with top wall, cancel if its a 1x1
		while(place_meeting(x,y,obj_solid) and !place_meeting(x,y+sprite_height/2,obj_solid))
			y++;
		while(place_meeting(x,y,obj_solid) and !place_meeting(x,y-sprite_height/2,obj_solid))
			y--;
		
		//magnet left
		var wall = instance_place(x-1,y,obj_solid);
		while(wall == noone or wall == killer)
		{
			x--;
			wall = instance_place(x-1,y,obj_solid);
		}
	}
	else
	{
		//try to avoid clipping with top wall, cancel if its a 1x1
		while(place_meeting(x,y,obj_solid) and !place_meeting(x,y+sprite_height/2,obj_solid))
			y++;
		while(place_meeting(x,y,obj_solid) and !place_meeting(x,y-sprite_height/2,obj_solid))
			y--;
		
		//magnet right
		var wall = instance_place(x+1,y,obj_solid);
		while(wall == noone or wall == killer)
		{
			x++;
			wall = instance_place(x+1,y,obj_solid);
		}
	}
}

#endregion

image_xscale = lerp(image_xscale,0.2,0.15);
image_yscale = lerp(abs(image_yscale),1.5,0.15);
instance_destroy(obj_player_eye);
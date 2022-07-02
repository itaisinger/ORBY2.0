///@description 
if(instance_exists(obj_pause)) exit;

#region check direction on the first frame

if(!checked)
{
	checked = 1;
	if(killer.grav < 0)
	{
		var yy = 0;
		while(place_meeting(x,y,killer) and !place_meeting(x,y-1,obj_wall))
			y--;
			
		while(!place_meeting(x,y-1+yy,obj_solid) and abs(yy)<64)
			yy--;
			
		y -= sprite_height;
		if(abs(yy)<64) 
			y += yy;
	}
	else
	{	
		//get up out of wall being pushed into
		var wall = instance_place(x,y,obj_solid);
		if(wall != noone and wall != killer)
			y = wall.bbox_top-1;
		
		//stick the nearest bottom floor
		var wall = instance_place(x,y+1,obj_solid);
		while(wall == noone or wall == killer)
		{
			y++;
			wall = instance_place(x,y+1,obj_solid);
		}
		
		while(place_meeting(x,y,obj_anvil))
		{
			var _spd = 0.16
			image_xscale = approach(image_xscale,_spd,2);
			image_yscale = approach(image_yscale,_spd,0.1);
			
			if(image_xscale == 2) break;
		}
			
		y++;
	}
}

#endregion

image_xscale = lerp(image_xscale,1.5,0.15);
image_yscale = lerp(abs(image_yscale),0.2,0.15)*sign(killer.grav);
image_yscale = max(min_ys,image_yscale);
instance_destroy(obj_player_eye);

if(follow_active != -1) follow_active = obj_player.dead
if(!follow_active) follow_active = -1;
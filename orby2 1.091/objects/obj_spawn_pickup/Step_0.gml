///@description 
if(instance_exists(obj_orb))
if(ds_list_find_index(obj_orb.list_savepoints,creation_num) != -1)
	instance_destroy();

switch(state)
{
	#region fly
	case SPAWNP_STATES.fly:
	
	image_index = 1;
	if(instance_exists(obj_orb))
	{
		var xdest = obj_orb.x;
		var ydest = obj_orb.y;
	
		var spd  = point_distance(x,y, xdest,ydest)/15;
		var dir  = point_direction(x,y, xdest, ydest);
		var xspd = abs(lengthdir_x(spd, dir))
		var yspd = abs(lengthdir_y(spd, dir))
		
		xspd = clamp(xspd,1,50);
		yspd = clamp(yspd,1,50);
		
		hsp += xspd;
		vsp += yspd;
		
		x = approach(x,hsp,xdest)
		y = approach(y,vsp,ydest)
		
		image_angle += spd;
		
		if(x == xdest and y == ydest)
		{
			ds_list_add(obj_orb.list_savepoints,creation_num);
			instance_destroy();
		}
	}
	
	break;
	#endregion
	#region natural
	case SPAWNP_STATES.natural:
	
	yoff = wave(-5,+5,5,0);
	y = ystart + yoff;
	depth = DEPTH.pickup;
	
	break;
	#endregion
	#region destroy
	
	case SPAWNP_STATES.destroy1:
	
	//var o = obj_player;
	//if(!instance_exists(obj_player)) o = obj_player_eye;
	
	
	//o.draw_xs = 1.5;
	//o.draw_ys = 1.5;
	
	obj_orb.pickup(creation_num);

	instance_destroy();
		
	break;
	
	#endregion
}
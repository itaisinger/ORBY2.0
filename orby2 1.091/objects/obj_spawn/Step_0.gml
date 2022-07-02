switch(state)
{
	#region create
	case SPAWN_STATES.create:
	
	if(instance_exists(obj_player))
	{
		var spd  = point_distance(x,y, xdest,ydest)/5;
		var dir  = point_direction(x,y, xdest, ydest);
		var xspd = abs(lengthdir_x(spd, dir))
		var yspd = abs(lengthdir_y(spd, dir))
		
		xspd = clamp(xspd,1,50);
		yspd = clamp(yspd,1,50);
			
		x = approach(x,xspd,xdest)
		y = approach(y,yspd,ydest)
		
		a_spd = point_distance(x,y, xdest,ydest)/4;
		image_angle += a_spd;
	
		if(x == xdest and y == ydest)
		{			
			state = SPAWN_STATES.natural;
			ystart = y;
		}
	}
	
	break;
	#endregion
	#region natural
	case SPAWN_STATES.natural:
	
	a_spd = approach(a_spd,1,1);
	image_angle += a_spd;
	
	yoff = wave(-5,+5,5,0);
	y = ystart + yoff;
	depth = DEPTH.orb_unlock;
	
	break;
	#endregion
	#region destroy
	
	case SPAWN_STATES.destroy:
	
	image_xscale -= 0.04;
	image_yscale -= 0.04;
	
	a_spd += 2;
	image_angle += a_spd;
	
	if(image_xscale < 0)
	{
		//ds_list_delete(obj_orb.list_savepoints,0);
		instance_destroy();
	}
	
	break;
	
	#endregion
}

#region lazy code to destroy if there is no savefile3/4

if(!file_exists(global.savefile3) and !file_exists(global.savefile4))
{
	show_debug_message("spawnpoint existsed with no matching savefile")
	instance_destroy();
}

#endregion
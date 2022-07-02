if(instance_exists(obj_pause)) exit;

a_dest = point_direction(x,y,obj_orb.x,obj_orb.y);
switch(state)
{
	///
	case UNLOCK_STATES.natural:	
	
	yoff = wave(-5,+5,5,0);
	y = ystart + yoff;
	image_angle = 0;
	scale = 0.7;
	
	break;
	////
	case UNLOCK_STATES.spin1:
	
	image_angle -= spd;
	if(image_angle < 0) image_angle += 360;
	
	if(spd > spd_min) spd = abs(a_dest-image_angle)/40;
	else
	{
		if(image_angle == a_dest)
		state = UNLOCK_STATES.fly;
		else
		state = UNLOCK_STATES.spin2;
		cnt = 0;
	}
	
	break;
	/////////////
	case UNLOCK_STATES.spin2:
	
	image_angle -= spd;
	if(image_angle < 0) image_angle += 360;
	
	var final_a = image_angle
	if(dir < 0)
	{
		final_a = image_angle - 180;
		if(final_a < 360) final_a += 360;
	}
		
	cnt++;
	if(is_in_range(final_a,50,a_dest) or cnt >= 120)
		state = UNLOCK_STATES.fly;
	
	break;
	///////////////////
	case UNLOCK_STATES.fly:
	
	var xdest = obj_orb.x;
	var ydest = obj_orb.y;
	
	spd += 0.4;
	var xspd = abs(lengthdir_x(spd, a_dest))
	var yspd = abs(lengthdir_y(spd, a_dest))
	
	x = approach(x,xspd,xdest)
	y = approach(y,yspd,ydest)
	
	//90  -> 270: 1
	//270 -> 90: -1
	
	if(a_dest > 90 and a_dest < 270)
		 image_angle = a_dest - 180;
	else image_angle = a_dest;
	
	if(place_meeting(x,y,obj_orb))
	{
		ds_list_add(obj_orb.unlock_list, index);
		obj_game.map_picked_orbs[?string(creation_num)] = true;
		state = UNLOCK_STATES.off;
	}
	
	break;
	////////////////////////////
	case UNLOCK_STATES.off:
		sprite_index = -1;
		mask_index   = -1;
		break;
}
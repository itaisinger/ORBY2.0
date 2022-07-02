if(instance_exists(obj_orb)) instance_destroy();
if(instance_exists(obj_pause)) exit;

switch(state)
{
	///
	case ORB_CREATE_STATES.natural:	
	
	yoff = wave(-5,+5,5,0);
	y = ystart + yoff;
	image_angle = 0;
	scale = 0.7;
	
	break;
	////
	case ORB_CREATE_STATES.spin1:
	
	image_angle -= spd;
	spd -= 0.1;
	
	if(spd < 0)
	{
		state = ORB_CREATE_STATES.spin2;
	}
	
	break;
	/////////////
	case ORB_CREATE_STATES.spin2:
	
	image_angle += spd;
	spd += 1;
	
	scale -= 0.006;
	
	if(scale < 0.3)
		state = ORB_CREATE_STATES.create;
	
	break;
	///////////////////
	case ORB_CREATE_STATES.create:
	image_angle += spd;
	r += 0.1;
	
	if(r > 14)
	{
		state = ORB_CREATE_STATES.create2;
		spd = r;
	}
	break;
	/////////////////
	case ORB_CREATE_STATES.create2:
	image_angle += spd;
	spd = approach(spd, 0.2, 0);
	r = approach(r, 0.2, 8);
	
	if(spd == 0 and r == 8)
	{
		state = ORB_CREATE_STATES._end;
	}
	break;
	/////////////////
	case ORB_CREATE_STATES._end:
	cnt++;
	
	if(cnt > 40)
	{
		with (instance_create_depth(x,y,0,obj_orb))
		{
			state_anim = ORB_ANIMS.create;
			spd_max = 0;
		}
		instance_destroy();
	}
	
	break;
}

if(image_angle > 360) image_angle -= 360;
obj_mouse.x = x;
obj_mouse.y = y;
///@description 

if !dead
	y = ystart + wave(-5,5,3,0);

if(place_meeting(x,y,obj_anvil))
{
	dead = true;
	while(place_meeting(x,y,obj_anvil))
		y++;
		
	if(place_meeting(x,y,obj_wall))
		instance_destroy();
}

var xoff_dest = 0;
var yoff_dest = 0;

if(look_at_me)
{
	var dir = point_direction(x,y, obj_player.x,obj_player.y);
	var len = 10;
	
	eye_scale = 1//approach(eye_scale, 0.001, 1.3);
	
	xoff_dest = lengthdir_x(len,dir);
	yoff_dest = lengthdir_y(len,dir);
}

eye_xoff = approach(eye_xoff, 0.1, xoff_dest);
eye_yoff = approach(eye_yoff, 0.1, yoff_dest);
///@description 
if(instance_exists(obj_pause)) exit;

image_angle += 1;

yoff = wave(-scale,scale,5,0);
y = ystart + yoff;

scale = approach(scale,0.15,base_scale)// + wave(-base_scale/4,base_scale/4,10,0));
depth = DEPTH.orb_unlock;

#region zoom

var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);
var ch = camera_get_view_height(view_camera[0]);
var cw = camera_get_view_width(view_camera[0]);

xonscreen = 0;
yonscreen = 0;

if(bbox_right > cx  and bbox_right < cx+cw)  xonscreen = 1;
if(bbox_left > cx   and bbox_left < cx+cw)   xonscreen = 1;
if(bbox_top > cy    and bbox_top < cy+ch)    yonscreen = 1;
if(bbox_bottom > cy and bbox_bottom < cy+ch) yonscreen = 1;

if(xonscreen and yonscreen and !instance_exists(obj_credits)) global.camera_zoom = 1.4;
else global.camera_zoom = 1.1;

#endregion
#region particles

if(alarm[0] == 1 and !global.flag_power_plant)
{
	with instance_create_depth(0,0,depth,obj_flying_energy)
	{
		x = random_range(-100,room_width+100);
		y = room_height+100;
		
		xdest = other.x;
		ydest = other.y;
	}
	
	alarm[0] = random_range(60,3*60);
}

if(place_meeting(x,y,obj_flying_energy) and !global.flag_power_plant)
{
	instance_destroy(instance_place(x,y,obj_flying_energy));
	//scale += 1;
	scale = scale*1.2;
}

#endregion
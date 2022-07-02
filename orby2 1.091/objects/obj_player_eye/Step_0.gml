///@description 
if(instance_exists(obj_pause)) exit;

if(vsp != 0) hsp = approach(hsp,air_fric,0);
else hsp = approach(hsp,ground_fric,0);

vsp += grav;

#region collision

var body = instance_place(x,y,obj_body);
if(body != noone)
{
	instance_deactivate_object(body);
}

var body = instance_place(x,y,obj_miner_body);
if(body != noone)
{
	instance_deactivate_object(body);
}

//vertical collision
if(place_meeting(x,y+vsp, obj_solid))
{
	while(!place_meeting(x,y+sign(vsp), obj_solid))
		y += sign(vsp);
		
	vsp *= -0.6;
}

//horizontal collision
if(place_meeting(x+hsp,y, obj_solid))
{
	while(!place_meeting(x+sign(hsp),y, obj_solid))
		x += sign(hsp);
	hsp *= -0.6;
}



#endregion
#region movement

//cancel vibrate
if(place_meeting(x,y+1,obj_solid))
{
	if(abs(vsp) < 1) vsp = 0;
	if(abs(hsp) < 1) hsp = 0;
}
x += hsp;
y += vsp;


if(body != noone)
{
	instance_activate_object(body);
}

#endregion
#region scale

draw_xs = approach(draw_xs, 0.03, 1);
draw_ys = approach(draw_ys, 0.03, 1);

#endregion
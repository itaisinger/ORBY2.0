///@description 
if(instance_exists(obj_pause)) exit;



if(!anchor)
{
	
if(vsp != 0) hsp = approach(hsp,air_fric,0);
else hsp = approach(hsp,ground_fric,0);

vsp += grav;

#region collision

//vertical collision
if(place_meeting(x,y+vsp, obj_solid))
{
	while(!place_meeting(x,y+sign(vsp), obj_solid))
		y += sign(vsp);
}

//horizontal collision
if(place_meeting(x+hsp,y, obj_solid))
{
	while(!place_meeting(x+sign(hsp),y, obj_solid))
		x += sign(hsp);
}


#endregion

x += hsp;
y += vsp;
}

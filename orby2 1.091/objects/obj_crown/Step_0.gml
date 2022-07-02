///@description 
if(instance_exists(obj_pause) or state == 1) exit;

if(vsp != 0) hsp = approach(hsp,air_fric,0);
else hsp = approach(hsp,ground_fric,0);

vsp += grav;

#region collision

instance_deactivate_object(obj_player_dead_squashed_v);

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

instance_activate_object(obj_player_dead_squashed_v);

#endregion
#region movement

//cancel vibrate
if(place_meeting(x,y+1,obj_solid))
{
	if(abs(vsp) < 2) 
	vsp = 0;
	//if(abs(hsp) < 0.4) hsp = 0;
}
x += hsp;
y += vsp;

#endregion
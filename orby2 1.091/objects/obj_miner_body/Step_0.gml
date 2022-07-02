///@description 
if(instagrav)
{
	instagrav--;
	event_user(0);
}

if(!place_meeting(x,y+1,obj_solid))
{
	vsp += grav;
}

collision_normal();

x += hsp;
y += vsp;

var min_a = 0.1;

if(instance_exists(obj_orb))
{
	if(obj_orb.state == ORB_STATES.yellow)
	{
		var dis = distance_to_object(obj_orb)
		image_alpha = max(min_a,1 - dis/450);
	} else image_alpha = min_a;
}
else image_alpha = min_a;
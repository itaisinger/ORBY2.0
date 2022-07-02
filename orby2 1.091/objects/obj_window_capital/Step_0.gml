///@description 
if(instance_exists(obj_orb))
if(obj_orb.state == ORB_STATES.yellow)
{
	var dis = distance_to_object(obj_orb)
	image_alpha = 1-dis/300;
} else image_alpha = 0;

if(image_alpha > 0.9) image_alpha = 1;
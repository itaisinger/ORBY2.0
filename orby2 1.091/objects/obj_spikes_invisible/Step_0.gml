///@description 
image_alpha = approach(image_alpha,0.1,get_invis_alpha());
 
if(instance_exists(obj_player))
	image_alpha = max(image_alpha,1-distance_to_object(obj_player)/30);


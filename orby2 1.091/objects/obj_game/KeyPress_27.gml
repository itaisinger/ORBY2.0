///@description 
if(room != rm_menu)
{
	if(instance_exists(obj_pause))
		instance_destroy(obj_pause)
	else
		instance_create_depth(0,0,0,obj_pause);
}
///@description menu
radius_dest = menu_radius;

//exit
if(room != rm_menu and !instance_exists(obj_pause))
{
	state = state_prev;
}
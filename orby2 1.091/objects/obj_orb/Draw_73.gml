///@description draw light menu over darkness
if(instance_exists(obj_darkness) and menu_active and unlocked_colors[| ORB_STATES.yellow] and state != ORB_STATES.menu)
{
	draw_set_alpha(0.15)
	draw_set_color(draw_colors[ORB_STATES.yellow]);
	draw_rectangle(light_menu_coords[0],light_menu_coords[1],light_menu_coords[2],light_menu_coords[3],0);
	
	draw_reset();
}
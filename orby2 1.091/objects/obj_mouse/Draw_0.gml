if(room == rm_pit_trailer) exit;
 var c = get_colors();
var color = 0;
var o = obj_orb;
if(instance_exists(o))
{
	color = merge_color(c[o.current_color],c[o.flash_color],o.flash_a);
	if(o.disabled) color = c[COLORS.gray];
	
	if(o.state == ORB_STATES.black and o.menu_mode)
		color = c_white;
}
else if(instance_exists(obj_menu_orb))
{
	color = c[obj_menu_orb.color]
}
else color = c_black;

draw_set_alpha(1)
draw_set_color(color);
draw_circle(mouse_x, mouse_y, 3, 0);

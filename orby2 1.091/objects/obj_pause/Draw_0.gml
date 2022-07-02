///@description 

if(instance_exists(obj_darkness)) 
{
	draw_set_color(c_white);
	draw_set_alpha(0.1);
}
else
{
	draw_set_color(c_black)
	draw_set_alpha(0.7);
}

draw_rectangle(0,0,room_width,room_height,0);
draw_reset();
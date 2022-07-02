///@description
draw_set_font(font);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(image_alpha)

x = window_get_width()/2 - (window_get_width()-camera_get_view_width(view_camera[0])/global.camera_zoom)/2
y = window_get_height()/2 + costum_y;

draw_text_outline(x,y,text,2,color);
draw_reset();

time_current++;
if(time_current > time_total)
{
	image_alpha -= 0.07;
	if(image_alpha < 0)
		instance_destroy();
}


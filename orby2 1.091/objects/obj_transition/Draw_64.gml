///@description 

if(room == rm_pit_trailer) exit;

var x1 = camera_get_view_x(view_current);
var y1 = camera_get_view_y(view_current);
var w = camera_get_view_width(view_current);
var h = camera_get_view_height(view_current);

if(state != TRANS_STATES.off)
{
	if(room == rm_blue_exit)
		draw_set_alpha(1);
	draw_set_color(draw_color);
	draw_rectangle(0,y1,   x1+w,y1+precent*h/2,0);
	draw_rectangle(0,y1+h, x1+w,y1+h-precent*h/2,0);
}
 
draw_reset();
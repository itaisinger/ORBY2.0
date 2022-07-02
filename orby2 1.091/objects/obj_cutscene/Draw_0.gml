//draw escape overlay
var x1 = obj_camera.x;
var y1 = obj_camera.y;
var w = camera_get_view_width(view_camera[0]);
var h = camera_get_view_height(view_camera[0]);

draw_set_color(c_white);
draw_set_alpha(escape_overlay_a);
draw_rectangle(0,0,x1+w,y1+h,0);

//draw bras
var _record = 0;
if(!draw_bars or _record) exit;



draw_reset();
draw_set_color(c_black);

precent = lerp(precent, 0.2*flick(destroy), 0.1);
draw_rectangle(x1,y1,   x1+w,y1+precent*h/2,0);
draw_rectangle(x1,y1+h, x1+w,y1+h-precent*h/2,0);

draw_reset();
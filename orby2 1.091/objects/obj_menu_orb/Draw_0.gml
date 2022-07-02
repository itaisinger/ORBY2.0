///@description 
var r = 6;
draw_set_color(get_colors(color));
draw_rectangle(x-r,y-r, x+r,y+r, 0);
var r = 4;
draw_set_color(get_colors_background(color));
draw_rectangle(x-r,y-r, x+r,y+r, 0);
draw_reset();
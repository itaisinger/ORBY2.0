///@description 
draw_set_color(my_color);
if(!uses) draw_set_color(get_colors(COLORS.gray));

var startx = x + r + 4;
var starty = y - r;

//draw normal
if(!placed)
{
	var xoff = 0, yoff = 0;
	if(error_frames)
	{
		xoff = random_range(-3,3);
		yoff = random_range(-3,3);
	}
	draw_rectangle(x+xoff-r,y+yoff-r, x+xoff+r,y+yoff+r, 0);
}
//draw platform
else
{
	draw_set_color(my_color);
	var startx = x + w/2 + 4;
	draw_rectangle(x-w/2,y-h/2, x+w/2,y+h/2, 0);
}


for(var i=0; i<uses_max; i++)
{
	if(i < uses) draw_set_color(my_color);
	else draw_set_color(get_colors(COLORS.gray));
	var s = 8;
	
	draw_rectangle(startx,starty, startx+s,starty+s, 0);
	starty += s+4;
}
draw_set_color(c_white);
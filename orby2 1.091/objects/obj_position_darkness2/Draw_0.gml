//// draw /////

//draw in the surface
if(!surface_exists(sur))
	sur = surface_create(grid_w,grid_h);

surface_set_target(sur);
draw_set_color(c_black);

for(var i = 0; i < grid_w; i++)
{
	for(var j = 0; j < grid_h; j++)
	{
		draw_set_alpha(grid_alpha[# i,j]);
		draw_rectangle(i,j, i+1,j+1, 0);
	}
}

draw_reset();
surface_reset_target();

//draw surface
var _startx = bbox_left;
var _starty = bbox_top;
draw_surface_ext(sur,_startx,_starty,32,32,0,c_white,1);
//surface_free(sur);

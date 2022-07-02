///@description 
function create_grid()
{
	grid_w = ceil(camera_get_view_width (view_camera[0])*zoom/32)+4;
	grid_h = ceil(camera_get_view_height(view_camera[0])*zoom/32)+3;
	
	ds_grid_destroy(grid_alpha);
	grid_alpha = ds_grid_create(grid_w,grid_h);
}

depth = DEPTH.darkness
zoom = global.camera_zoom;
grid_alpha = ds_grid_create(0,0);
create_grid();
points_num_prev = 0;
points = [];
first = 1;
sur = -1;


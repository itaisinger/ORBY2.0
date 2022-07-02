///@description 
function create_grid()
{
	grid_w = ceil((bbox_right-bbox_left)/32);
	grid_h = ceil((bbox_bottom-bbox_top)/32);
	
	ds_grid_destroy(grid_alpha);
	grid_alpha = ds_grid_create(grid_w,grid_h);
}

depth = DEPTH.darkness
grid_alpha = ds_grid_create(0,0);
create_grid();
points_num_prev = 0;
points = [];
first = 1;
sur = -1;

if(!instance_exists(obj_darkness_points))
	instance_create_depth(0,0,0,obj_darkness_points);

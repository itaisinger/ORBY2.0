
#region scan for light opints 

if(instance_exists(obj_pause)) depth = DEPTH.darkness_pause;
else						   depth = DEPTH.darkness;

points = []; //each entry is an array of 3 vars: [x,y,r]

//orb
if(obj_orb.state == ORB_STATES.yellow)
	points[0] = [obj_orb.x,obj_orb.y,200];

//lamps
var _inst = noone;
for(var i=0; i < instance_number(obj_lamp); i++)
{
	_inst = instance_find(obj_lamp,i);
	points[array_length(points)] = [_inst.x,_inst.y,_inst.radius];
}

//assign points to the grid
for(var i=0; i < array_length(points); i++)
{
	points[i][0] = points[i][0];
	points[i][1] = points[i][1];
}

#endregion
#region calculate alphas

//descide wether a recheck is necessary (might be bad when camera moves)
var _recheck = 1;
var _arr_l = array_length(points);

if(instance_exists(obj_orb))
	_recheck = obj_orb.state == ORB_STATES.yellow 
	or _arr_l != points_num_prev 
	or first
	or obj_camera.camera_moved

points_num_prev = _arr_l;

//recheck
if(_recheck)
{
	//if no points, just clear.
	ds_list_clear(list_alpha)
	var max_a = global.darkness_alpha;
	
	
	var w = 32;
	var a = max_a;
	var m = my_a;
	if(my_a == -1) m = 1;
	var _startx = bbox_left;
	var _starty = bbox_top;
	var _total_w = bbox_right;
	var _total_h = bbox_bottom;
	
	
	//// calculate /////
	for(var i=_startx; i <= _total_w; i+=w)
	{
		for(var j=_starty; j <= _total_h; j+=w)
		{
			var _min_dis = -1, _min_i = -1;
			var _dis;
			
			//loop through points
			for(var k=0; k < _arr_l; k++;)
			{
				_dis = point_distance(i,j,points[k][0],points[k][1]);
				if(_dis < _min_dis or _min_dis = -1)
				{
					_min_dis = _dis;
					_min_i = k;
				}
			}
			
			//calculate alpha based on rage found
			if(_min_i == -1)
				a = max_a
			else
			{
				var _range = points[_min_i][2]
				_range *= global.light_radius_multi;
				a = clamp((_min_dis/_range)/4,0,max_a);
			}
			
			ds_list_add(list_alpha,a*m);
		}
	}

}

#endregion
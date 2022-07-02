#region scan for light opints 

if(instance_exists(obj_pause)) depth = DEPTH.darkness_pause;
else						   depth = DEPTH.darkness;

points = obj_darkness_points.points; //each entry is an array of 3 vars: [x,y,r]

var _startx = bbox_left;
var _starty = max(bbox_top,obj_camera.y-obj_camera.y%32);

#endregion
#region calculate alphas

//descide wether a recheck is necessary
var _recheck = 1;
var _arr_l = array_length(points);

if(instance_exists(obj_orb))
	_recheck = obj_orb.state == ORB_STATES.yellow 
	or _arr_l != points_num_prev 
	or first
	or obj_camera.camera_moved

points_num_prev = _arr_l;
 
//add fake point for first frame
if(first)
{
	points[0] = [0,0,0];
	first = 0;
}

//recheck
if(_recheck)
{
	var max_a = my_a;
	var a = max_a;
	var _total_w = bbox_left + grid_w*32;
	var _total_h = bbox_top  + grid_h*32;
	var xx = 0, yy = 0;
	
	//// calculate ///// 
	for(var i=_startx; i < _total_w; i += 32)
	{
		for(var j=_starty; j < _total_h; j += 32)
		{
			var _min_dis = -1, _min_i = -1;
			var _dis;
			
			//loop through points
			for(var k=0; k < _arr_l; k++;)
			{
				_dis = power(power(points[k][0]-i,2) + power(points[k][1]-j,2),0.5);
				if(_dis < _min_dis or _min_dis = -1)
				{
					_min_dis = _dis;
					_min_i = k;
				}
			}
			
			//calculate alpha based on range found
			if(_min_i == -1)
				a = my_a;
			else
			{
				var _range = points[_min_i][2]
				_range *= global.light_radius_multi;
				a = clamp((_min_dis/_range)/4,0,max_a);
			}
			
			grid_alpha[# yy,xx++] = a;
		}
		
		xx = 0;
		yy++;
	}

}

#endregion
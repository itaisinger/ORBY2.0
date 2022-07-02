
function get_invis_alpha(){
	
	if(ds_list_find_index(global.disruptors,COLORS.yellow) != -1)
		return 0;
	
	//returns the accurate alpha according to nearby yellow orb and lamps
	var o = obj_orb;
	var _alpha1 = 0;
	if(instance_exists(o))
	{
		if(o.state == ORB_STATES.yellow)
		{
			var dis = distance_to_object(o)
			_alpha1 = 1 - dis/200;
		}
	}

	var _light = instance_nearest(x,y,obj_lamp);
	var _alpha2 = 0;
	if(_light != noone)
		_alpha2 = 1 - distance_to_object(_light)/_light.radius;
	
	return max(_alpha1,_alpha2);
}
///@description 
image_index = ORB_STATES.yellow;
time_base = room_speed*5;
time_remain = time_base;
destroy = 0;
//base_r = 200;
radius = 0;
image_angle = 45;
depth = DEPTH.lamp;
progress = 0;
image_xscale = 0.2;
image_yscale = 0.2;

function remove(){
	//call this when time_remain = 0 to remove myself from orb list.
	
	var _l = obj_orb.list_lamps
	var _p = -1;
	for(var i=0; i < ds_list_size(_l) and _p == -1; i++)
	{
		if(_l[|i] == id)
			_p = i;
	}
	
	destroy = 1;
	ds_list_delete(_l,_p);
}
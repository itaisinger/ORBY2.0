function global_get_orb_picked(argument0) {
	with(obj_game)
	{
		var i = string(argument0);
		var _ret = ds_map_find_value(map_picked_orbs,i);
		
		if(_ret != undefined) return _ret;
		else return 0;
		//if(ds_list_size(list_picked_orbs) <= i)
		//{
		//	list_picked_orbs[|i] = 0;
		//	return false;
		//}
		//return list_picked_orbs[|i];
	}


}

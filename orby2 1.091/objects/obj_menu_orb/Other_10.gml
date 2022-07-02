//load unlocked colors
if(file_exists(global.savefile))
{
	var _wrapper = load_JSON_from_file(global.savefile);
	var _list = _wrapper[? "ROOT"];
	
	for(var i=0; i < ds_list_size(_list); i++;)
	{
		var _map = _list[|i];
		var _obj = _map[? "obj"];
		
		if(_obj == "obj_orb")
			unlocked_colors = ds_list_deep_clone(_map[? "unlocks_colors"]);
	}
	ds_map_destroy(_wrapper);
	
	if(!list_sum(unlocked_colors))
	{
		unlocked_colors = ds_list_create();
		unlocked_colors[|ORB_STATES.black] = 1;
	}
}
else
{
	unlocked_colors = ds_list_create();
	unlocked_colors[|ORB_STATES.black] = 1;
}
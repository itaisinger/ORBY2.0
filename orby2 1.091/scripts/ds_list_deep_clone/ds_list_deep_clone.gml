///@desc ds_list_deep_clone()
///@arg0list
function ds_list_deep_clone(argument0) {

	if(argument0 == -1 or argument0 == undefined or is_undefined(argument0))
		return ds_list_create();
		
	var _source = argument0;
	var _map = ds_map_create();
	ds_map_add_list(_map,"list",_source);
	var _str = json_encode(_map);

	//cleanup
	ds_map_delete(_map,"list"); //remove the source before destroying to not destroy it
	ds_map_destroy(_map);

	_map = json_decode(_str);
	var _ret = _map[?"list"];

	//cleanup
	ds_map_delete(_map,"list"); //remove the _ret before destroying to not destroy it
	ds_map_destroy(_map);

	return _ret;


}

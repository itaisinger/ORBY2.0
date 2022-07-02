///@desc string_from_map()
///@arg0map
function string_from_map(argument0) {

	var map = argument0;
	var str = "";
	var size = ds_map_size(map);
	var key  = ds_map_find_first(map);

	for(var i=0; i < size; i++)
	{
		str += string(key) + ":" + string_from_array(ds_map_find_value(map, key),"") + ",";
		key = ds_map_find_next(map,key);
	}

	return str;


}

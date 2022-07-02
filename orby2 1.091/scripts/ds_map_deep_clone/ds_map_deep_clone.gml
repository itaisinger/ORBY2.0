///@desc ds_map_deep_clone()
///@arg0ds
function ds_map_deep_clone(argument0) {
	
	//catch null
	if(argument0 == -1 or argument0 == undefined or is_undefined(argument0))
		return ds_map_create();
	
	var map, json, clone;
	map   = argument0;
	json  = json_encode(map);
	clone = json_decode(json);
	return clone;

	//all hail the one line ds map deep clone!
	//return json_decode(json_encode(argument0));


}

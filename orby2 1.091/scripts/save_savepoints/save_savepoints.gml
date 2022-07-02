function save_savepoints() {
	if(instance_exists(obj_orb))
	{
		var path = global.savefile2;
		var _wrapper = ds_map_create();
		ds_map_add_list(_wrapper,"savepoints",ds_list_deep_clone(obj_orb.list_savepoints));

		var _string = json_encode(_wrapper);
		save_string_to_file(path,_string);

		//cleanup
		ds_map_destroy(_wrapper)
	}
	else
	{
		var path = global.savefile2;
		var _wrapper = ds_map_create();
		ds_map_add_list(_wrapper,"savepoints",ds_list_create());
	
		var _string = json_encode(_wrapper);
		save_string_to_file(path,_string);
		//ds_map_secure_save(_wrapper,global.savefile2);

		//cleanup
		ds_map_destroy(_wrapper)
	}


}

///@desc ds_list_sort_by_id()
///@arg0list
function ds_list_sort_by_id(argument0) {

	//returns a new list of instances sorted by their unique instance id.
	//leaves the original list untouched.

	var source = ds_list_create();
	ds_list_copy(source,argument0);
	var _new = ds_list_create();
	var _max = -1;
	var inst = noone;
	var add_i = -1;

	while(ds_list_size(source))
	{
		_max = -1;
		for(var i=0; i < ds_list_size(source); i++)
		{
			inst = source[|i];
			if(inst.id > _max) 
			{
				_max = inst.id;
				add_i = i;
			}
		}
	
		ds_list_add(_new,source[|add_i]);
		ds_list_delete(source,add_i);
	}

	ds_list_destroy(source);
	return _new;


}

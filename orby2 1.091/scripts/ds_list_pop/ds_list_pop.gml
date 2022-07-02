///@desc ds_list_pop()
///@arg0list
function ds_list_pop(argument0) {

	var list = argument0;
	var val = list[|ds_list_size(list)-1];
	ds_list_delete(list,ds_list_size(list)-1);
	return val;


}

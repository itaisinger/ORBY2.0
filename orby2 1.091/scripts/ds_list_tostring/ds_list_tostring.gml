///@desc ds_list_tostring()
///@arg0list
function ds_list_tostring(argument0) {

	var list = argument0;
	var str = "{";

	for(var i=0; i < ds_list_size(list); i++)
	{
		str += string(list[|i]);
		if(i+1 < ds_list_size(list))
			str += ", "
	}

	str += "}";

	return str;


}

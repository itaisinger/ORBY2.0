///@dsc returns a flat string of all the array vars ()
///@arg0list
///@arg1sep
function string_from_list(argument0, argument1) {
	var str = "";
	for(var i=0; i<ds_list_size(argument0); i++)
	{
		str += string(argument0[|i]);
		str += argument1;
	}

	return str;


}

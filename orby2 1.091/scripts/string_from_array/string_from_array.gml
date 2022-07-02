///@dsc returns a flat string of all the array vars ()
///@arg0array
///@arg1sep
function string_from_array(argument0, argument1) {
	var str = "";
	for(var i=0; i<array_length_1d(argument0); i++)
	{
		str += string(argument0[i]);
		str += argument1;
	}

	return str;


}

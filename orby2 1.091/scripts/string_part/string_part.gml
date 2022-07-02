///@desc string_part()
///@arg0string
///@arg1start
///@arg2end
function string_part(argument0, argument1, argument2) {

	//returns a part of a string

	var full  = argument0;
	var ret   = "";
	var start = argument1;
	var _end  = argument2;

	for(var i=start; i <= _end; i++)
	{
		ret += string_char_at(full,i);
	}

	return ret;


}

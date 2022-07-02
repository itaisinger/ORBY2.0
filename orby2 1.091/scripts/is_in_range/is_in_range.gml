///@desc is_in_range
///@arg val
///@arg range
///@arg goal
function is_in_range(argument0, argument1, argument2) {

	var val   = argument0;
	var range = argument1;
	var goal  = argument2;

	if(val > goal and val - range < goal) return true;
	if(val < goal and val + range > goal) return true;
	return false;


}

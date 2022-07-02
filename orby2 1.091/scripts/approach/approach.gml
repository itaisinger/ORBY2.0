///@desc approach()
///@arg0val
///@arg1speed
///@arg2goal
function approach(argument0, argument1, argument2) {

	var val = argument0;
	var spd = argument1;
	var goal = argument2;

	if(val<goal) return min(val+spd, goal);
	if(val>goal) return max(val-spd, goal);
	return val;


}

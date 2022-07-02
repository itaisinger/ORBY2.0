///@desc array_sum()
///@arg0arr
function array_sum(argument0) {
	var sum = 0;

	for(var i=0; i < array_length_1d(argument0); i++)
	{
		sum += argument0[i];
	}

	return sum;


}

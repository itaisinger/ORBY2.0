///@desc list_sum()
///@arg0arr
function list_sum(argument0) {
	var sum = 0;

	for(var i=0; i < ds_list_size(argument0); i++)
	{
		sum += argument0[|i];
	}

	return sum;


}

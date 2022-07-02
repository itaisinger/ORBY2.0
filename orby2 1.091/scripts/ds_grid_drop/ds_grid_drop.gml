
function ds_grid_drop(_grid,_x,_y,_val,_fall){
	/*/
	this is a recoursive function that sets a value to a cell in a grid
	and then sets the value-falloff to the cells around it and repeats for those cells until the value reaches 0.
	
	this function is built spesifically for the darkness grid in orby 2 and must be altered and generelized in 
	order to be useful in other cenarios.
	/*/
	
	//set the cell if its lower than the value
	if(_grid[# _x,_y] > _val)
		_grid[# _x,_y] = _val
	
	//decrement
	_val += _fall;
	
	if(_val < 1)
	{
		if(_x+1 < obj_darkness.grid_w)
			ds_grid_drop(_grid,_x+1,_y,_val,_fall)
		
		if(_x-1 >= 0)
			ds_grid_drop(_grid,_x-1,_y,_val,_fall)
		
		if(_y+1 < obj_darkness.grid_h)
			ds_grid_drop(_grid,_x,_y+1,_val,_fall)
			
		if(_y-1 >= 0)
			ds_grid_drop(_grid,_x,_y-1,_val,_fall)
	}
	
	log("recourse val " + string(_val) + "ended");
}
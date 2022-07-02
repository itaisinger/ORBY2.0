///@description 
if(instance_number(obj_capital) < global.max_capitals)
{
	if(cooldown>0) cooldown--;
	else
	{
		cooldown = irandom_range(60,10*60);
		
		if(capital_count_prev == instance_number(obj_capital))
			instance_create_depth(x,y,depth,obj_capital)
	}

}
capital_count_prev = instance_number(obj_capital);

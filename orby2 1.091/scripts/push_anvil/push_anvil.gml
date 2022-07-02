function push_anvil() {
	var o_anvil = instance_place(x+hsp,y,obj_anvil);
	with(o_anvil)
	{
		var xadd = other.hsp;
		push_anvil();
	
		while(place_meeting(x+xadd,y,obj_solid)) 
			xadd = approach(xadd,1,0);
	
		x += xadd;
	}


}

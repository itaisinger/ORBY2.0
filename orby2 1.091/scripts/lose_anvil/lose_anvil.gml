///@desc lose_anvil()
function lose_anvil() {

	if(has_anvil)
	{
		var anvil = instance_create_layer(x,y,"all",obj_anvil_pickup);
		anvil.creation_num = anvil_index;
		anvil.vsp = 0;
		anvil.hsp = hsp;
		anvil.grav_amp = sign(grav_amp);
	
		anvil_index = -1;
		has_anvil = false;
	}


}

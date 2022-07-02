if(other.killer != id and !global.flag_power_plant)
{
	play_sfx(sfx_power_plant);
	
	hit();
	
	if(base_scale > 0)
		other.killer = id;

}
///@description blue
current_color = COLORS.blue;

if(key_1)
{
	if(grav_used)
	{
		play_sfx(sfx_error)
		error_frames = 20;
	}
	else
	{
		grav_flipped = !grav_flipped;
		obj_player.grav_amp *= -1;
		
		with(obj_anvil) grav *= -1;
		with(obj_anvil_pickup) grav_amp *= -1;
		grav_used = 1;
		
		if(grav_flipped) play_sfx(sfx_grav);
		else play_sfx(sfx_degrav);
	}
}

disabled = grav_used;
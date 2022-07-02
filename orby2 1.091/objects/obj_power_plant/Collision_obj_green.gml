if(other.killer != id)
{
	other.killer = id;
	audio_sound_pitch(sfx_power_plant,1 + (15-base_scale)/10)
	play_sfx(sfx_power_plant);
	hit();
}
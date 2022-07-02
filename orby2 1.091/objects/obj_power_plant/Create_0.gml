///@description 
scale = 0;
base_scale = 15;
alarm[0] = 10;
anchor = 0;
global.game_end = 0;
flash_frames = 0;

function hit()
{
	base_scale = approach(base_scale,3,0);
	
	if(base_scale <= 0)
	{
		audio_stop_sound(sfx_power_plant);
		play_sfx(sfx_power_plant_slow);

		//trigger destruction cutscene
		global.flag_power_plant = 1;
		with(instance_create_depth(0,0,0,obj_cutscene))
		{
			index = CUTSCENES.destruction;
		}
	}
	
	flash_frames = 30;
}
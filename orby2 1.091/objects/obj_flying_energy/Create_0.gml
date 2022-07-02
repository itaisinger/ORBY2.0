///@description 
speed = 4;
xdest = -20;
ydest = -20;
my_sound = 0;

if(room == rm_pit_bottom)
{
	my_sound = play_sfx(sfx_deposit);
	audio_sound_pitch(my_sound,random_range(0.7,1.3))
}
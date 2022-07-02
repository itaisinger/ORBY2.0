//destroy overllaps
if(audio_is_playing(sfx_land) and audio_is_playing(sfx_refill))
	audio_stop_sound(sfx_land);
	
if(fright_cooldown > 0 and audio_is_playing(sfx_capital_fright))
	audio_stop_sound(sfx_capital_fright);
	
fright_cooldown = approach(fright_cooldown,1,0);
clang_cd = approach(clang_cd,1,0);


//outros overlapp
if(audio_is_playing(sfx_outro) and audio_is_playing(sfx_outro_credits))
	audio_stop_sound(sfx_outro);
	
	
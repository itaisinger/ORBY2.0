function play_sfx(sound){
	var _id = audio_play_sound(sound,SOUND.sfx,0);
	
	audio_sound_gain(_id,global.sfx_volume,0);
	
	if(sound == sfx_capital_fright)
		obj_sfx.fright_cooldown = 40;
		
	return _id;
}

function text_fade(_text,yy,_color){
	instance_destroy(obj_text_fade);
	
	with instance_create_depth(0,0,DEPTH.ui_text,obj_text_fade)
	{
		costum_y = yy;
		text = _text;
		color = _color;
	}
}
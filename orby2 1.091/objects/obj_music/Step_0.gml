#region ost by cutscene

if(instance_exists(obj_cutscene))
{
	switch(obj_cutscene.index)
	{
		case CUTSCENES.turnover: 
			if(obj_player.turned_precent>0)
				current_song = list_ost[|OST.turn]; break;
		case CUTSCENES.turnover_capital:
			if(obj_player.turned_precent>0)
				current_song = list_ost[|OST.turn]; break;
				
		case CUTSCENES.kinghood: 
		with(obj_cutscene)
			other.current_song = other.list_ost[|ost_index]; 
		break;
		case CUTSCENES.fall1: current_song = list_ost[|OST.fall]; break;
		case CUTSCENES.fall2: current_song = list_ost[|OST.fall]; break;
		case CUTSCENES.fall3: current_song = list_ost[|OST.fall]; break;
	}
}

if(instance_exists(obj_credits))
	current_song = list_ost[|OST.credits];

if(room == rm_level_5 and !obj_game.list_played_scenes[|CUTSCENES.fall1] and obj_transition.state == TRANS_STATES.goto)
and (obj_transition.precent > 0.9)
	current_song = list_ost[|OST.fall];
	

#endregion

#region nostalgia volume

if(room == rm_ravine_temple and instance_exists(obj_player))
{
	var _inst = instance_find(obj_trigger,0);
	var _dis = point_distance(obj_player.x, obj_player.y,	_inst.x,_inst.y)
	
	nos_vol = clamp(0,(1300-_dis)/1300,1)
}

#endregion

var _t = 2500;
var _vol_dest = global.music_volume*global.music_volume_amp*nos_vol;



//switch song
if(current_song != list_ost[|OST.none] and !audio_is_playing(list_ost[|OST.fall]))
if(!audio_is_playing(current_song))
{	
	//play new song
	var loop = current_song != list_ost[|OST.fall];
	ds_list_add(list_sound_ids,audio_play_sound(current_song,SOUND.music,loop));
	
	//fade out other songs
	for(var i=0; i<ds_list_size(list_sound_ids); i++;)
	{
		//fade out
		var _vol = _vol_dest*(audio_get_name(list_sound_ids[|i]) == audio_get_name(current_song));
		audio_sound_gain(list_sound_ids[|i],_vol,_t)
	}
}



for(var i=0; i<ds_list_size(list_sound_ids); i++;)
{
	//match gain to user volume
	if(audio_get_name(list_sound_ids[|i]) == audio_get_name(current_song))
		audio_sound_gain(list_sound_ids[|i],_vol_dest,0)
	else
	//delete faded out (is put in "else" to not delete current track when user volume = 0
	if(audio_sound_get_gain(list_sound_ids[|i]) < _vol_dest/10)
	{
		audio_stop_sound(list_sound_ids[|i]);
		ds_list_delete(list_sound_ids,i)
		i--;
	}
	//if they are not faded out, make them!
	else audio_sound_gain(list_sound_ids[|i],0,_t/2);
}

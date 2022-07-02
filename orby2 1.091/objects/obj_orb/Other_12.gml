///@description yellow
current_color = COLORS.yellow;

//the code is run soley from the wall objects.

//create lamps


/*/
if pressing left click
	check if hovering over a lamp
		if so, destroy it
		else, check if light_remain>0
			if so, create a lamp
			
dilema - should lamps be stored in a stack and when pressing when having no lamp,
the oldest lamp will auto destroy?
/*/

light_remain = light_max - ds_list_size(list_lamps);//instance_number(obj_lamp);

if(key_1 and light_max)
{
	//if out of lamps, destroy the last lamp.
	if(!light_remain)
	{
		var _lamp = list_lamps[|0];
		_lamp.remove();
		light_remain++;
	}
	
	//create lamp
	with(instance_create_depth(x,y,0,obj_lamp))
	{
		//add to list (they remove themselves when destroying)
		ds_list_add(other.list_lamps,id)
	}
}

//sound
var _pos = audio_sound_get_track_position(light_sfx);
if(_pos > total_length)
{
	audio_sound_set_track_position(light_sfx,_pos-loop_length);
}
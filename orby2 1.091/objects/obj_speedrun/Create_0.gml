///@description 
enum CHECKPOINTS{
	button1,
	button2,
	button3,
	button4,
}

active = 0;
time = 0;
reached_ending = 0;
stop = 0;
flash_a = 0;

get_time = function(){
	if(!is_undefined(time)) time = 0;
	var _time = global.map_run_times[?global.savefile];
	var _times = array_create(4,0);
	var _str = "";

	for(var i=0; i<4; i++)
	{
		_times[i] = floor(_time/power(60,3-i));
		_time -= _times[i]*power(60,3-i);
	
		var cs = string(_times[i]);
		if(_times[i] < 10)
			cs = "0" + cs;
		_str += ":" + cs;
	}

	_str = string_delete(_str,1,1);
	return _str;
}
time_to_string = function(_time){
	if(is_undefined(_time)) _time = 0;
	var _times = array_create(4,0);
	var _str = "";
	
	for(var i=0; i<4; i++)
	{
		_times[i] = floor(_time/power(60,3-i));
		_time -= _times[i]*power(60,3-i);
	
		var cs = string(_times[i]);
		if(_times[i] < 10)
			cs = "0" + cs;
		_str += ":" + cs;
	}
	
	_str = string_delete(_str,1,1);
	return _str;
}

depth = GUI_DEPTH.clock;

list_end_times = ds_list_create();

for(var i=0; i<4; i++)
	list_end_times[|i] = 0;
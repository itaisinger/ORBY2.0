if(room == rm_menu or !active) 
	exit;

var ch = camera_get_view_height(view_current);
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

var _scale = 0.7;// + 0.2*flash_a;

draw_set_all(c_white,font_menu,1,fa_left,fa_bottom);
draw_text_outline_ext(8,ch,_str,3,c_black, _scale);

var col = merge_color(c_yellow,c_white,0.5);
draw_set_all(col,font_menu,flash_a,fa_left,fa_bottom);
draw_text_transformed(8,ch,_str,_scale,_scale,0);
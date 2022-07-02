//// draw /////

if(! ds_list_size(list_alpha)) exit;

var w = 32;
var _startx = obj_camera.x - obj_camera.x%32;
var _starty = obj_camera.y - obj_camera.y%32;
var _total_w = _startx + window_get_width()  + w;
var _total_h = _starty + window_get_height() + w;
var _index = 0;
draw_set_color(c_black);

for(var i = _startx; i <= _total_w; i+=w)
{
	for(var j = _starty; j <= _total_h; j+=w)
	{
		draw_set_alpha(list_alpha[| _index++]);
		draw_rectangle(i,j, i+w-1,j+w-1, 0);
	}
}
draw_reset();

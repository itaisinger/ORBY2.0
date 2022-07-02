//// draw /////
var w = 32;
var _startx = bbox_left;
var _starty = bbox_top;
var _total_w = bbox_right;
var _total_h = bbox_bottom;
var _index = 0;
draw_set_color(c_black);

for(var i = _startx; i <= _total_w; i+=w)
{
	for(var j = _starty; j <= _total_h; j+=w)
	{
		draw_set_alpha(list_alpha[| _index++]);
		draw_rectangle(floor(i),floor(j), floor(i+w-1),floor(j+w-1), 0);
	}
}
draw_reset();

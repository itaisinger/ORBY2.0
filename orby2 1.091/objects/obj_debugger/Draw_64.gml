///@description 

//if(!active) exit;
draw_set_all(c_black,font_ui,1,fa_left,fa_top);

var xx = 5, yy = 5 - 5000*(!active);
var off = 2;

for(var i=0; i < ds_list_size(vars); i++)
{
	draw_text_double(xx,yy,vars[|i],off,c_white);
	yy += 5 + string_height(vars[|i]);
}
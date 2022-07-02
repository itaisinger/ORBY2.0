
//update
text = string(obj_game.energy_deposited);
#region text stuff

//setup colors
var colors		   = array_create(0,0);
var outline_colors = array_create(0,0);
	
colors[SHADES.normal] = color_base;
colors[SHADES.light]  = merge_color(color_base,c_white, 0.2);
colors[SHADES.dark]   = merge_color(color_base,c_black, 0.3);
colors[SHADES.dark2]  = merge_color(color_base,c_black, 0.5);

outline_colors[SHADES.normal] = outline_base_color;
outline_colors[SHADES.light]  = merge_color(outline_base_color,c_white, 0.2);
outline_colors[SHADES.dark]   = merge_color(outline_base_color,c_black, 0.3);
outline_colors[SHADES.dark2]  = merge_color(outline_base_color,c_black, 0.5);

//"create" bbox
draw_set_font(font);
var margin = 10;
image_xscale = (string_width(text) +margin*2) * (scale+scale_add);
image_yscale = (string_height(text)+margin*2) * (scale+scale_add);

//stick to bbox
x = xstart - image_xscale/2;
y = ystart - image_yscale/2;

depth = DEPTH.text;

#endregion

//alpha
if(instance_exists(obj_orb))
{
	if(obj_orb.state == ORB_STATES.yellow)
	{
		var dis = distance_to_object(obj_orb)
		image_alpha = 1 - dis/200;
	} else image_alpha = 0;
}
else image_alpha = 0;
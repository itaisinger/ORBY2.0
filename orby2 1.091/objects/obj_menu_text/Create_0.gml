//visual
text = "null";
color_base = c_white
color = color_base;
outline_color = c_black;
outline_base_color = c_black
outline_width = 0;
setup_colors = true;

font = font_message;
depth = DEPTH.ui_text;
halign = fa_left;
valign = fa_top;
scale = 1;
scale_add = 0;

//logic
state = 0;
return_value = -1;
parent = noone;
mask_index = mask_pixel;

enum TEXT_STATES{
	natural,
	hover,
	hold,
	off,
}

enum SHADES{
	normal,
	dark,
	dark2,
	light,
}
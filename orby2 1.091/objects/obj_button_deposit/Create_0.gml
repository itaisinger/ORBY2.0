//visual
text = "deposit\nenergy";
color_base = make_color_rgb(240,240,240);
color = color_base;
outline_color = make_color_rgb(112,112,112);
outline_base_color = outline_color;
outline_width = 2;
setup_colors = true;

font = font_message;
depth = DEPTH.wall;
halign = fa_left;
valign = fa_top;
scale = 0.5;
scale_add = 0;

//logic
state = 0;
return_value = -1;
parent = noone;
mask_index = mask_pixel;

action = "none";
counter = 0;
wall_l = noone;
wall_r = noone;
alarm[0] = 10;
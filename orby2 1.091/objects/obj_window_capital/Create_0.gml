///@description
margin = sprite_get_width(spr_capital)/2;
cx = x+random_range(margin,sprite_width-margin);
cy = y+sprite_height-1;

if(cx%64 < 3) cx += 5;

//visuals
eye_xoff = 0;
eye_yoff = 0;
eye_dir  = 1;
sq_off   = 0;
depth = DEPTH.wall+1;

sprite_index = -1;
mask_index = -1;
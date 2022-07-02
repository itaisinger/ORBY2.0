///@description
if(is_capital)
{
	sprite_index = spr_capital;
	eyeout_spr = spr_capital_eyeout;
}

draw_self();
draw_sprite_ext(eyeout_spr,0,x+xoff,y+yoff,image_xscale,image_yscale,0,c_white,1);
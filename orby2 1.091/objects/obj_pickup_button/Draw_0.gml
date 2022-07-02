///@description 
draw_self();

var xoff = 8*sign(image_xscale)*(image_angle != 0)
var yoff = 8*sign(image_yscale)*(image_angle == 0)

if(pressed)
	draw_sprite_ext(spr_key_effect_b,0,x+xoff,y-yoff,image_xscale,image_yscale,image_angle,c_white,effect_a);
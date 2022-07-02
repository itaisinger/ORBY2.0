///@description 
draw_self();

var xoff = sprite_get_xoffset(spr_key_indexes);
var yoff = sprite_get_yoffset(spr_key_indexes);
draw_sprite_ext(spr_key_indexes,index-1,x+xoff,y+yoff+wave(5,-5,5,-5),0.8,0.8,0,c_white,1);

if(pressed)
	draw_sprite_ext(spr_key_effect,0,x,y-8,1,1,0,c_white,effect_a);
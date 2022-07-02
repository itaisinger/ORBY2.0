// Activating the shader
bktglitch_activate();

high();

var _m = 1;
if(_rand == 2)
{
	_m = 3;
}

var _inten = clamp(_m*(1-distance_to_object(obj_orb)/100),0.25*_m,0.8)
bktglitch_set_intensity(_inten);

//var _w = 16;
//for(var _xx = bbox_left; _xx <= bbox_right; _xx += _w)
//{
//	for(var _yy = bbox_top; _yy <= bbox_bottom; _yy += _w)
//		draw_sprite(sprite_index,0,_xx-16,_yy-16)
//}

image_alpha = 0.5;
draw_self();

//draw_glitched(sprite_index,0,x-16,y-16,image_xscale,image_yscale,1,_inten,0.3)

// Done with the shader (this is really just shader_reset)!
bktglitch_deactivate();

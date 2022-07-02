image_xscale = draw_xs;
image_yscale = draw_ys;

draw_self();

#region draw eye 

var eye_spd = 1;
var eye_xmax = (sprite_get_width(spr_eyeout) *image_xscale)/2 - sprite_get_width(spr_eye)/2;

//horizontal
	 if(dir < 0)  eye_xoff = approach(eye_xoff, eye_spd, -eye_xmax);
else if(dir > 0)  eye_xoff = approach(eye_xoff, eye_spd,  eye_xmax);
else			  eye_xoff = approach(eye_xoff, eye_spd/2, 0);

var eye_x = x + eye_xoff;
var eye_y = y - sprite_height/2 + eye_yoff + 1; //for some reason it draws the eye one pixel upwards..

if(eye_xoff != 0)
	eye_dir = sign(-eye_xoff);

//eyeout angle
//7,12
var eye_s = eye_scale;
if(state != GREEN_STATES.anvil)	//draw normal
	draw_sprite_ext(spr_miner_eyeout,eyeout_index, x,y+sq_off-15*image_yscale,image_xscale*eye_s,image_yscale*eye_s,0,c_white,image_alpha);
else							//draw joyful
	draw_sprite_part_ext(spr_miner_eyeout,eyeout_index, 
	0,0,20,12,
	x,y+sq_off-15*image_yscale,
	image_xscale*eye_s,image_yscale*eye_s,
	c_white,image_alpha);
	
if(draw_xs > 0.1)
draw_sprite_ext(spr_eye,0, eye_x,eye_y, eye_dir*eye_s ,eye_s,0,c_white,1);

#endregion
#region draw overlay

draw_sprite_ext(spr_miner_hover,0,x,y,image_xscale,image_yscale,0,c_white,frozen);

#endregion
#region draw jump overlay
 
//doesnt work
//if(jump_amp != 1 or jump_ampx != 0)
//draw_sprite_ext(spr_jump_glow,0,x,y,image_xscale,image_yscale,0,c_white,1);

#endregion
image_xscale = 1;
image_yscale = 1;

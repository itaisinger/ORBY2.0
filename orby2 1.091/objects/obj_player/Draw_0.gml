if(dead) exit;
if(draw_xs < 0) exit;

image_xscale = max(0,draw_xs);
image_yscale = max(0,draw_ys);

#region draw jump reset effect

float_anim_precent = approach(float_anim_precent,0.07,!float_reset_used);
if(float_anim_precent < float_anim_prev)
{
	draw_set_alpha(0.3)
	var xs = image_xscale*(2-float_anim_precent);
	draw_sprite_ext(spr_jump_glow,1,x,y,xs,image_yscale,0,c_white,0.3*float_anim_precent);
}

float_anim_prev = float_anim_precent;

#endregion
#region draw self

draw_self();

//turnover
var curve = animcurve_get(cur_turnover);
var channel = animcurve_get_channel(curve,0);

var draw_precent = animcurve_channel_evaluate(channel,turned_precent);
var left   = 0;
var width  = sprite_width;
var top    = 0;
var height = sprite_height*draw_precent;
var _xs = 1;
var _ys = draw_ys;
if(draw_xs > 1)
{
	_ys = 1;
	_xs = draw_xs;
}
draw_sprite_part_ext(spr_capital,0, left,top,width,height,x-sprite_width/2,y-sprite_height,_xs,_ys,-1,1);


#endregion
#region draw eye

if(draw_eye)
{
	
var eye_spd = 1;
var eye_xmax = (sprite_get_width(spr_eyeout)*image_xscale)/2  - sprite_get_width(spr_eye)/2;
var eye_ymax = (sprite_get_height(spr_eyeout)*image_yscale)/2 - sprite_get_width(spr_eye)/2;

if(!is_paused) //when unpaused, look when the arrows are pointing.
{
	
//vertical
	 if(key_down) eye_yoff = approach(eye_yoff, eye_spd, eye_ymax);
else if(key_up)   eye_yoff = approach(eye_yoff, eye_spd, -eye_ymax);
else			  eye_yoff = approach(eye_yoff, eye_spd, 0);
//horizontal
	 if(key_left)  eye_xoff = approach(eye_xoff, eye_spd, -eye_xmax);
else if(key_right) eye_xoff = approach(eye_xoff, eye_spd,  eye_xmax);
else			   eye_xoff = approach(eye_xoff, eye_spd, 0);

var eye_x = x + eye_xoff;
var eye_y = y - sprite_height/2 + eye_yoff + sq_off + 1; //for some reason it draws the eye one pixel upwards..

}
else //when paused, look at orb
{

var eye_xdest = clamp(obj_mouse.x-x, -eye_xmax,eye_xmax);
var eye_ydest = clamp(obj_mouse.y-(y-sprite_height/2), -eye_ymax,eye_ymax);

eye_xoff = approach(eye_xoff,eye_spd,eye_xdest);
eye_yoff = approach(eye_yoff,eye_spd,eye_ydest);

var eye_x = x + eye_xoff;
var eye_y = y - sprite_height/2 + eye_yoff + sq_off;

}

if(eye_xoff != 0)
	eye_dir = sign(-eye_xoff);

var s_eyeout = spr_eyeout;
var s_eye	 = spr_eye;

if(is_capital)
{
	s_eyeout = spr_capital_eyeout;
	s_eye	 = spr_capital_eye;
}

draw_sprite_ext(s_eyeout,0, x,y+sq_off,image_xscale,image_yscale,image_angle,c_white,image_alpha);
draw_sprite_ext(s_eye,0, eye_x,eye_y, eye_dir ,1,0,c_white,1);

}
#endregion
#region draw jump glow

if(jump_amp+jump_ampx != 2)
{
	//jump_glow_alpha -= 0.02;
	//if(jump_glow_alpha < 0) jump_glow_alpha = 1;
	
	//draw_set_alpha(jump_glow_alpha)
	draw_sprite_ext(spr_jump_glow,0,x,y,image_xscale,image_yscale,0,c_white,1);
}
//else jump_glow_alpha = 1;

//draw_reset();
#endregion
#region draw float glow

if(floating and !float_reset_used)
{
	draw_set_alpha(0.3);
	draw_sprite_ext(spr_jump_glow,0,x,y,image_xscale,image_yscale,0,c_white,1);
	float_anim_precent = 1;
}

draw_reset();
#endregion
#region draw anvil armor

if(has_anvil) draw_sprite_ext(spr_player_anvil,0,x,y,image_xscale,image_yscale,0,c_white,image_alpha);

#endregion
#region draw crown

if(is_king)
{
	if(grav > 0)
	{
		crown_y  = approach(crown_y,8,-sprite_height/2);
		crown_ys = approach(crown_ys,0.1,1);
	}
	if(grav < 0)
	{
		crown_y  = approach(crown_y,8,sprite_height/2);
		crown_ys = approach(crown_ys,0.1,-1);
	}

	draw_sprite_ext(spr_crown,0,x,y-sprite_height/2+crown_y,1,crown_ys,0,c_white,1);
}

#endregion

//draw_text(x,y,floating)
image_xscale = 1;
image_yscale = 1;
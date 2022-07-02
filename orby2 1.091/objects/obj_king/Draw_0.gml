
draw_self();

#region draw eye 

var eye_x = x + eye_xoff;
var eye_y = y - sprite_height/2 + eye_yoff/2 + 1; //for some reason it draws the eye one pixel upwards..

if(eye_xoff != 0)
	eye_dir = sign(-eye_xoff);

draw_sprite_ext(spr_capital_eyeout,0, x+eye_xoff/2,y+sq_off+eye_yoff/2,image_xscale,image_yscale,image_angle,c_white,image_alpha);
draw_sprite_ext(spr_capital_eye,0, eye_x,eye_y, eye_dir*eye_scale,eye_scale,0,c_white,1);

#endregion

draw_sprite(spr_crown,0,x,bbox_top-1);
///@description 
#region magnet to ceiling

var draw_ground = place_meeting(x,y+1,obj_solid);

image_xscale = draw_xs;
image_yscale = draw_ys;

var yoff = 0;
if(grav < 0)
{
if(draw_ground and !place_meeting(x,y-1+yoff,obj_solid))
	yoff--;

while(place_meeting(x,y+yoff,obj_solid))
	yoff++;
}

if(abs(yoff)>20) yoff = 0;
y += yoff;
#endregion
#region draw self

if(state != CAPITAL_STATES.anvil)
{
	draw_self();
}
else
{
	draw_sprite(sprite_index,0,my_anvil.x,my_anvil.y)
}

#endregion
#region draw eye 

if(state != CAPITAL_STATES.anvil)
{
 
var eye_spd = 1 - 0.6*(state == CAPITAL_STATES.run);
var eye_xmax = (sprite_get_width(spr_eyeout) *image_xscale)/2 - sprite_get_width(spr_eye)/2;
var eye_ymax = (sprite_get_height(spr_eyeout)*image_yscale)/2 - sprite_get_width(spr_eye)/2;

//vertical
	 if(0) eye_yoff = approach(eye_yoff, eye_spd, eye_ymax);
else if(0) eye_yoff = approach(eye_yoff, eye_spd, -eye_ymax);
else	   eye_yoff = approach(eye_yoff, eye_spd, 0);
//horizontal
	 if(walk_dis < 0)  eye_xoff = approach(eye_xoff, eye_spd, -eye_xmax);
else if(walk_dis > 0)  eye_xoff = approach(eye_xoff, eye_spd,  eye_xmax);
else				   eye_xoff = approach(eye_xoff, eye_spd/2, 0);

var eye_x = x + eye_xoff;
var eye_y = y - sprite_height/2 + eye_yoff + 1; //for some reason it draws the eye one pixel upwards..

if(eye_xoff != 0)
	eye_dir = sign(-eye_xoff);

var eye_ys = 1;
if(state == CAPITAL_STATES.despawn)
	eye_ys = image_yscale;

draw_sprite_ext(spr_capital_eyeout,0, x,y+sq_off,draw_xs,draw_ys,image_angle,c_white,image_alpha);
draw_sprite_ext(spr_capital_eye,0, eye_x,eye_y, eye_dir,1,0,c_white,1);

}
else
{

var eye_x = 32;
var eye_y = 32;

var out_x  = eye_x;
var out_y  = eye_y + 15;

draw_sprite_ext(spr_capital_eyeout,0, my_anvil.x+out_x,my_anvil.y+out_y,image_xscale,image_yscale,image_angle,c_white,image_alpha);
draw_sprite_ext(spr_capital_eye,0,    my_anvil.x+eye_x,my_anvil.y+eye_y, eye_dir,1,0,c_white,1);

//ds_list_destroy(passengers);
}

#endregion

image_xscale = 1;
image_yscale = 1;
y -= yoff;

draw_set_color(c_black)
//draw_text(x,bbox_top-5,place_meeting(x,y,obj_solid));
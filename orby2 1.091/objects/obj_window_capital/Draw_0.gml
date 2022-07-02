///@description 
draw_set_alpha(image_alpha);
sprite_index = spr_window;


var window_num = floor(sprite_width/sprite_get_width(spr_window))
cx = min(cx,x+64*window_num-margin);

//draw back
for(var i=0; i<window_num; i++;)
	draw_sprite_ext(spr_window,0,x+64*i,y,1,1,0,c_white,image_alpha);

//draw capital
draw_sprite_ext(spr_capital,0,cx,cy,1,1,0,c_white,image_alpha);

var eye_x = cx + eye_xoff;
var eye_y = cy - 32/2 + eye_yoff + 1; //for some reason it draws the eye one pixel upwards..

if(eye_xoff != 0)
	eye_dir = sign(-eye_xoff);

draw_sprite_ext(spr_capital_eyeout,0, cx,cy+sq_off,1,1,0,c_white,image_alpha);
draw_sprite_ext(spr_capital_eye,0, eye_x,eye_y, eye_dir ,1,0,c_white,image_alpha);

for(var i=0; i<window_num; i++;)
{
	draw_sprite_ext(spr_window,1,x+i*64,y,1,1,0,c_white,image_alpha*0.4); //draw front
	draw_sprite_ext(spr_window,2,x+i*64,y,1,1,0,c_white,image_alpha*0.9); //draw border
}

draw_reset();
sprite_index = -1;
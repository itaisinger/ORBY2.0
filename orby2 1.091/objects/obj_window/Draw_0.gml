///@description 
draw_set_alpha(1);
sprite_index = spr_window;


var window_num = floor(sprite_width/sprite_get_width(spr_window))

//draw back
//for(var i=0; i<window_num; i++;)
//	draw_sprite_ext(spr_window,0,x+64*i,y,1,1,0,c_white,image_alpha);

for(var i=0; i<window_num; i++;)
{
	draw_sprite_ext(spr_window,1,x+i*64,y,1,1,0,c_white,image_alpha*0.4); //draw front
	draw_sprite_ext(spr_window,2,x+i*64,y,1,1,0,c_white,image_alpha*0.9); //draw border
}

draw_reset();
sprite_index = -1;
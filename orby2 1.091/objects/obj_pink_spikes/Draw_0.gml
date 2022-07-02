///@description 
if(!double){
	draw_self()
	exit;
}

var xx = x + lengthdir_x(32,image_angle);
var yy = y + lengthdir_y(32,image_angle);
draw_sprite_ext(spr_pink_spikes,0,x ,y ,1,image_yscale,image_angle,c_white,1)	//first part
draw_sprite_ext(spr_pink_spikes,0,xx,yy,1,image_yscale,image_angle,c_white,1)	//second part
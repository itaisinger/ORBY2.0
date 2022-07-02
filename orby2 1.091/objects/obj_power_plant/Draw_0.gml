///@description 
image_xscale = scale;
image_yscale = scale;

if(flash_frames > 0 and wave(-1,1,0.07,0) > 0)
{
	draw_sprite_ext(sprite_index,0,x,y,base_scale,base_scale,image_angle,c_white,1)
}
else draw_self();

flash_frames = approach(flash_frames,1,0);

image_xscale = scale/2;
image_yscale = scale/2;
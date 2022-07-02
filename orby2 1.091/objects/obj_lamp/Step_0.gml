///@description 
if(instance_exists(obj_pause)) exit;

radius = 200//approach(radius,5,base_r*(time_remain/time_base));

if(time_remain > 0 and !destroy)
{
	y = ystart + wave(-6,6,2,0);
	time_remain--;
	if(time_remain == 0) remove();
	
	var _size = 1//
	image_xscale = approach(image_xscale,0.05,_size);
	image_yscale = approach(image_yscale,0.05,_size);
	
	//image_angle = lerp(40,405,time_remain/time_base)
}

if(destroy)
{
	y = approach(y,1,ystart);
	progress += 0.02;
	var _cur = animcurve_get(cur_lamp);
	var _channel = animcurve_get_channel(_cur,0);
	var _scale = animcurve_channel_evaluate(_channel,progress);
	var _channel = animcurve_get_channel(_cur,1);
	var _angle = animcurve_channel_evaluate(_channel,progress);
	
	image_angle = _angle;
	image_xscale = _scale;
	image_yscale = _scale;
	
	if(progress >= 1)
		instance_destroy();
}
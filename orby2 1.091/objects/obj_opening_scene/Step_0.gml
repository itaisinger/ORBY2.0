///@description 
progress_prec += 1;

if(progress_prec >= progress_max)
{
	destroy = 1;
}

if(destroy)
{
	image_alpha -= 0.04;
	
	if(image_alpha < 0)
		instance_destroy();
} 
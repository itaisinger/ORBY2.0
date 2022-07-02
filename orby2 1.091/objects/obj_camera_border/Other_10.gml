///@description 
with(obj_camera)
{
	if(other.is_ease)
	{
		xmin = lerp(xmin,other.bbox_left,0.1);
		xmax = lerp(xmax,other.bbox_right,0.1);
		ymin = lerp(ymin,other.bbox_top,0.1);
		ymax = lerp(ymax,other.bbox_bottom,0.1);
	}
	else
	{	 
		xmin = other.bbox_left;
		xmax = other.bbox_right;
		ymin = other.bbox_top;
		ymax = other.bbox_bottom;
	}
}
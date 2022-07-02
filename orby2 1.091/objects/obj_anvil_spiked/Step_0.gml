///@description 
event_inherited();
#region create spikes

if(is_spiked)
{
	is_spiked = 0;
	
	spike_top = instance_create_layer(x,y,"all",obj_spikes);
	spike_bottom = instance_create_layer(x,y,"all",obj_spikes);
	
	spike_bottom.image_yscale = -1;
	spike_bottom.depth = DEPTH.wall+1;
	spike_top.depth = DEPTH.wall+1;
}

with (spike_top)    y = other.y-sprite_height;
with (spike_bottom) y = other.y-sprite_height*2;

with (spike_top)    depth = DEPTH.wall+1;
with (spike_bottom) depth = DEPTH.wall+1;



#endregion
///@description 
depth = DEPTH.spike;
anchor = true;

vsp = 0;
hsp = 0;
killer = -4;
destroy_when_off = 0;
instagrav = 15;
is_pink = 0;

if(image_angle = 0 and image_xscale = 1 and image_yscale = 1)
{
	
	if(instagrav)
	{
		instagrav--;
		while(!place_meeting(x,y+1,obj_wall))
			y++;
	}
}
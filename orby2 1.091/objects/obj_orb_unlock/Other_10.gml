///@description reset on load

if(obj_game.map_picked_orbs[?creation_num])
	state = UNLOCK_STATES.off;
else
{
	x = xstart;
	y = ystart;
	
	yoff = 0;
	state = 0;
	
	spd = 10;
	fly_spd = 0;	
}
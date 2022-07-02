///@desc collision
function collision_spikes() {


	//wall collisions

	//vertical collision
	if(place_meeting(x,y+vsp, obj_wall))
	{
		while(!place_meeting(x,y+0.2, obj_wall))
			y += 0.2;
		vsp = 0;
	}


}

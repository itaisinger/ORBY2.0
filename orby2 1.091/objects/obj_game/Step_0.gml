///@description restart on player death
if(instance_exists(obj_player) and !instance_exists(obj_pause))
if(obj_player.killer != noone and !global.flag_power_plant)
{
	death_cnt++;
	
	if(death_cnt == 70)
		transition(TRANS_STATES.restart);
}

//lazy ass worksarounds.
if(load_flip_anvils)
{
	with(obj_anvil) grav *= -1;
	load_flip_anvils = 0;
}

#region detect endings
if(!instance_exists(obj_credits))
{

//obedience 
if(energy_deposited > 29 and !list_got_endings[|ENDINGS.obedience])
{
	list_got_endings[|ENDINGS.obedience] = true;
	obj_speedrun.reached_ending = 1;
	obj_music.current_song = obj_music.list_ost[|OST.credits];
	
	
	if(obj_transition.state == TRANS_STATES.off)
	{
		with instance_create_depth(0,0,0,obj_credits)
		{
			end_index = ENDINGS.obedience;
		}
	}
}

//escape
if(instance_exists(obj_player))
if(room == rm_blue_exit and obj_player.y < 0)
{
	list_got_endings[|ENDINGS.escape] = true;
	obj_speedrun.reached_ending = 1;
	obj_music.current_song = obj_music.list_ost[|OST.credits];
	
	if(obj_transition.state == TRANS_STATES.off)
	{
		with instance_create_depth(0,0,0,obj_credits)
		{
			end_index = ENDINGS.escape;
		}
	}
}

//destruction
if(global.flag_destruction)
{
	global.flag_destruction = 0;
	list_got_endings[|ENDINGS.destruction] = true;
	obj_speedrun.reached_ending = 1;
	obj_music.current_song = obj_music.list_ost[|OST.credits];
	
	if(obj_transition.state == TRANS_STATES.off)
	{
		with instance_create_depth(0,0,0,obj_credits)
		{
			end_index = ENDINGS.destruction;
		}
	}
}

}
#endregion
#region deposit rewards

//wether the player has recieved those rewards or not is saved as 
//wether the cutscene has played or not in list_played_scenes.

/*/
rewards by order:
yellow  5
orange	10
purple	15
pink	20
green	25
end		30
/*/

if(!instance_exists(obj_cutscene))
{
	//reward1
	if(energy_deposited >= reward_cost[0] and !list_played_scenes[|CUTSCENES.reward1])
	{
		with(instance_create_depth(0,0,0,obj_cutscene))
			index = CUTSCENES.reward1;
	}
	
	//reward2
	if(energy_deposited >= reward_cost[1] and !list_played_scenes[|CUTSCENES.reward2])
	{
		with(instance_create_depth(0,0,0,obj_cutscene))
			index = CUTSCENES.reward2;
	}
	
	//reward3
	if(energy_deposited >= reward_cost[2] and !list_played_scenes[|CUTSCENES.reward3])
	{
		with(instance_create_depth(0,0,0,obj_cutscene))
			index = CUTSCENES.reward3;
	}
	
	//reward4
	if(energy_deposited >= reward_cost[3] and !list_played_scenes[|CUTSCENES.reward4])
	{
		with(instance_create_depth(0,0,0,obj_cutscene))
			index = CUTSCENES.reward4;
	}
	
	//reward5
	if(energy_deposited >= reward_cost[4] and !list_played_scenes[|CUTSCENES.reward5])
	{
		with(instance_create_depth(0,0,0,obj_cutscene))
			index = CUTSCENES.reward5;
	}
}
#endregion


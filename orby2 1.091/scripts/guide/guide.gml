function guide() {
	/*/

	//load system
	o saveload has event for loading the game normally - location + progress.
	it has another user event - load savepoint, that just loads the location.
	to load a savepoint, just load the game normally and then run the the other savepoint load event.

	//capital run dir
	run_dir starts at 0. move dir var is what direction he is running in.
	when run dir is 0, move dir is set to away from player.
	once the capital is faced againts a wall he cant cross, run dir changes to -1.
	from this point the capital ignores the player and looks for the exit by flipping run dir
	whenever he is faced againts a wall.

	//blue route
	go up the pit and press key 4
	go down to the bottom and get blue orb
	climb back up with anvil
	impossible (or atleast not required) to get through hub and levels with anvil
	climb up hub levels and press the key 5 on the top
	top exit on the other side unlocked and is first ending.
	route through for anvil though blue hub is also unlocked. this way you can bring anvils
	from the map into the control room at the top.
	bring 4 anvils to press the button and unlock the palace for turnover ending.
	bring an additional anvil and crush the king for kinghood ending.

	//endgame
	create obj credits and set an end_index to it to trigger end game and credits.
	obj_credits cleans up non relevent objs, and calls TRANS_STATES.goto_credits.
	
	//speedrun clock
	the runtimes file will be loaded by obj_menu when it is created, to avoid loading it multipile times.
	obj_speedrun will use and increment that var directly.
	the game will update the file just in the game_end function.
	the file will contain a ds_map of all saves.
	map_runs_times[?"savefile_base_name"] = time_in_frames
	
	//map_picked_unlocks
	every orb_unlock has a unique creation_num given to it in the room editor. when picking it, 
	it insert a new value to map_picked_orbs:
	map_picked_orbs[?string(creation_num)] = true;
	upon creating, it checks for that value. if it finds it, it self destructs.
	the same thing happens for distruptors.
	
	//destruction route
	objective: drop 5 miners into the power plant
	miner 1: blue generator, locked behind capital walls.
	miner 2: 20 energy deposited
	miner 3: light extra levels completed
	miner 4: got in miner experiments
	miner 5: yourself
	
	//wall recolor
	there is a wall color shader that replaced a rgb with another.
	obj game has a color array array that saves the rgb of walls for different worlds.
	at the start of a room a checks the room's **name** and if it starts with "rm_pink" or "rm_blue"
	it sets global.wall_color_arr to the respective array.
	since obj_game doesnt draw anything, its depth is set to 1 beneath walls, so it could set the shader
	right before they draw.
	
	disruptors have their own shaders so it messes things up, but worry not. the entire wall color system
	is mashed into the disruptor's, they apply all the arrays by themselves again. since there are not 
	many disruptors in the same room at once its not a big deal.
	
	for some reason the shader doesnt turn on for the walls, so they just use the image index that is
	set each time in the room creation code.

/* end guide */
}

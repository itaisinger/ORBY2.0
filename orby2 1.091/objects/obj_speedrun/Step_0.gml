//make sure there is time
if(!ds_map_exists(global.map_run_times,global.savefile))
{
	global.map_run_times[?global.savefile] = 0;
	log("no time for for this run. creating a new one.");
}


//count time
if(room != rm_menu and !stop and !instance_exists(obj_pause))
global.map_run_times[?global.savefile]++;

//active
active = global.speedrun_active;

if(reached_ending and !stop)
{
	stop = 1;
	flash_a = 1;
	play_sfx(sfx_refill);
}

flash_a = approach(flash_a,0.03,0);

//set score (done from obj_credits)
//with(obj_credits)
//{
//	if(other.list_end_times[|end_index] == 0)
//		other.list_end_times[|end_index] = other.get_time();
//}
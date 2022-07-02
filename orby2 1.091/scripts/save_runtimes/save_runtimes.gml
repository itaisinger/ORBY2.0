// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_runtimes(){
	var _string = json_encode(global.map_run_times);
	save_string_to_file(RUNTIMES,_string); 
	log("runtimes file saved");
}
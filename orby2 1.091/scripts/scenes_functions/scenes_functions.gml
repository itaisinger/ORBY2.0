function generate_miner(){
	var miner = instance_create_depth(obj_trigger.x,obj_trigger.y+16,DEPTH.player,obj_miner);
	instance_destroy(miner.my_orb);
	miner.eyeout_index = 0;
	miner.grav = 0;
}

function sequence_end_message(){
	show_message("sequence ended");
}
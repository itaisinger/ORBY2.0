loop = 0;
instant = 0;
miner_dir = -1;
miner_type = MINERS.normal;
alarm[0] = 60*4;
depth = 1000;

if(!instance_exists(obj_credits))
	instance_destroy();
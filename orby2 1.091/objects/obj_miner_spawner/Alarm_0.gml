///@description 
var miner = instance_create_depth(x,y,depth,obj_miner);
miner.state = miner_type;
miner.dir   = miner_dir;
miner.eye_a = miner_a;

if(!loop) instance_destroy();
alarm[0] = irandom_range(delay*0.7,delay*1.3);
///@description 
miner_type = MINERS.normal;  //what miner to spawn
instant = 0;				//wether to instantly spawn the miner or not
loop = 0;				    //wether to spawn just one miner or not
delay = room_speed*120;		//delay between spawns
miner_dir = 0;				//set this to prechoose the direction the miner will go
miner_a = 0;				//preset the eyeout a
alarm[0] = irandom_range(delay*0.7,delay*1.3);


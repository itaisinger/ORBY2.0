///@description 
if(counter > 0) counter--;
else 
{
	if(!instance_exists(obj_player))
	{
		instance_create_depth(x,y,0,obj_player);
		instance_destroy(obj_miner);
		instance_destroy(obj_miner_spawner);
		instance_destroy(obj_player_eye);
	}
	//else instance_create_depth(x,y,0,obj_miner);
	instance_destroy();
}
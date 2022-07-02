loop = 0;
instant = 1;
miner_dir = 1;
miner_type = MINERS.normal;

if(obj_game.list_played_scenes[|CUTSCENES.purple1]) 
{
	instance_create_depth(obj_trigger.x,obj_trigger.y,depth,obj_body);
	instance_destroy()
}
obj_game.list_played_scenes[|CUTSCENES.purple1] = true;
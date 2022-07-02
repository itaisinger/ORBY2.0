///@description 
with obj_saveload event_user(0);

//destroy the top exit
var ex = noone;
for(var i=0; i<instance_number(obj_exit); i++)
{
	ex = instance_find(obj_exit,i);
	if(ex != noone)
	if(ex.room_dest == rm_blue_1)
		instance_destroy(ex);
}

instance_destroy(obj_miner_spawner);
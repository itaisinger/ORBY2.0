///@desc load
if(instance_exists(obj_cutscene))
	instance_destroy(obj_cutscene);

with obj_saveload
{
	event_user(SAVELOAD.load);
	if(file_exists(global.savefile3)) 
	{
		 event_user(SAVELOAD.load_savepoint);
		 with(obj_spawn) state = SPAWN_STATES.destroy;
	}
}
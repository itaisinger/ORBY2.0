///@desc load checkpoint
with obj_saveload event_user(SAVELOAD.load);
with obj_saveload event_user(SAVELOAD.load_savepoint);

with(obj_spawn) state = SPAWN_STATES.destroy;
if(load_anvil_index != -1)
{
	obj_player.anvil_index = load_anvil_index;
	load_anvil_index = -1;
}
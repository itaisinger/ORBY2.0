///@description 
if(!obj_player.is_paused)
transition(TRANS_STATES.goto,room_dest,entrance_dest);
collide = 1;
obj_game.save_game = 1;
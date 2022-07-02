///@description
//depth = DEPTH.ui_base;
depth = GUI_DEPTH.trans;
if(state != TRANS_STATES.off)
{
	switch(state)
	{
		case TRANS_STATES.intro:
			var spd = max(precent/7, 0.005);
			precent = approach(precent, spd, 0);
				
			if(precent == 0)
			{
				spd_var = 1;
				state = TRANS_STATES.off;
			}
			break;
				
		case TRANS_STATES.goto:
			var spd = max((1-precent)/7, 0.005);
			precent = approach(precent, spd, 1);			
			
			if(precent == 1)
			{
				state = TRANS_STATES.intro;
				room_goto(target_room);
				if(instance_exists(obj_player))
					obj_player.room_entrance = target_enter;
			}
			break;
		
		case TRANS_STATES.restart:
			//animation
			var spd = max((1-precent)/7, 0.005);
			precent = approach(precent, spd, 1);
			
			if(precent == 1)
			{
				with(obj_game) event_user(GAME_EVENTS.load_game);
				state = TRANS_STATES.intro;
			}
			break;
		
		////not in use
		case TRANS_STATES.load:
			//animation
			var spd = max((1-precent)/7, 0.005);
			precent = approach(precent, spd, 1);
				
			if(precent == 1)
			{
				with(obj_game) event_user(GAME_EVENTS.load_game);
				state = TRANS_STATES.intro;		
			}
			break;
		/////////////////////////////////
		case TRANS_STATES.load_checkpoint:
			//animation
			var spd = max((1-precent)/7, 0.005);
			precent = approach(precent, spd, 1);
				
			if(precent == 1)
			{
				obj_game.load_anvil_index = obj_player.anvil_index;
				with(obj_game) event_user(GAME_EVENTS.load_checkpoint);
				state = TRANS_STATES.intro;		
			}
			break;
		
		///////////////////////////
		case TRANS_STATES.menu:
			var spd = max((1-precent)/7, 0.005);
			precent = approach(precent, spd, 1);
		
			if(precent == 1)
			{
				room_goto(rm_menu);
				instance_destroy(obj_orb);
				instance_destroy(obj_player);
				state = TRANS_STATES.intro;
			}
			break;
		
		//////////////////////////////
		case TRANS_STATES.ending:
			var spd = max((1-precent)/7, 0.005)/2;
			precent = approach(precent, spd, 1);
		
			if(precent == 1)
			{
				instance_create_depth(0,0,0,obj_credits);
				obj_credits.end_index = target_room;
				state = TRANS_STATES.intro;
			}
			break;
		/////////////////////////////////////
		case TRANS_STATES.goto_credits:
			var spd = max((1-precent)/7, 0.005)/spd_var;
			precent = approach(precent, spd, 1);			
			
			if(precent == 1)
			{
				
				state = TRANS_STATES.intro;
				room_goto(target_room);
			}
			break;
	}
}

//sfx
if(state_prev != state and state == TRANS_STATES.intro)
	play_sfx(sfx_intro);

state_prev = state;
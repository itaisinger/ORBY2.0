///@description
depth = DEPTH.ui_game;

if(active)
{

vars[|0] = "debugger ";
vars[|1] = "float: " + string(obj_player.floating);
vars[|2] = "precent: " + string(obj_transition.precent);

if(keyboard_check_pressed(ord("C")))
{
	obj_player.is_capital = 1;
}

if(keyboard_check_pressed(ord("V")))
{
	obj_player.anvil_index = 1;
}

if(keyboard_check_pressed(ord("L")))
{
	ds_list_add(obj_orb.list_savepoints,1);
}

if(keyboard_check_pressed(ord("R")))
{
	room_restart();
}

if(keyboard_check_pressed(ord("P")))
{
	with(obj_wall) if(sprite_index == spr_wall) sprite_index = spr_wall_debug;
}

if(keyboard_check_released(ord("E")))
{
	if(keyboard_check(vk_shift))
	{
		obj_game.list_got_endings[|ENDINGS.kinghood] = 1;
		obj_game.list_got_endings[|ENDINGS.turnover] = 1;
	}
	else
	{
		obj_player.is_capital = 0;
		obj_player.is_king = 0;
		ds_list_destroy(obj_game.list_got_endings);
		obj_game.list_got_endings = ds_list_create();
	}
}
if(keyboard_check_pressed(ord("B")))
{
	ds_list_add(obj_orb.unlock_list,ORB_STATES.yellow);
	ds_list_add(obj_orb.unlock_list,ORB_STATES.blue);
}

//goto rooms
if(keyboard_check_pressed(vk_escape) and room == rm_menu)
{
	transition(TRANS_STATES.goto,rm_test,0);
}

if(keyboard_check_pressed(vk_numpad1))
{
	transition(TRANS_STATES.goto,room+1,0);
}
if(keyboard_check_pressed(vk_numpad2))
{
	transition(TRANS_STATES.goto,room-1,0);
}

}
///@description
enum ENDINGS{
	escape,
	turnover,
	kinghood,
	obedience,
	destruction,
}

play_sfx(sfx_outro_credits);
end_index = 0;

list_text_insts = ds_list_create();

engding_texts[0] = "escape";
engding_texts[1] = "turnover";
engding_texts[2] = "kinghood";
engding_texts[3] = "obedience";
engding_texts[4] = "destruction";

text_rooms = [rm_blue_hub,rm_pit_top,rm_pit_middle,rm_pit_bottom];

//room 1
//ORBY
credits_text[0] = "ending got: ";

//room 2
credits_text[1] = "a game by Itai Singer"
credits_text[2] = "soundtrack by Matan Koresh"

//room 3
credits_text[3] = "motivational support:\n\nOhad\n\nIdo\n\nYuval\n\nDana\n\nAdam\n\nGuny\n\nMatan\n\nAriel"

//room 4
credits_text[4] = "alpha and beta testing:\n\nOrian\n\nHodaya\n\nBar\n\nAltman\n\nNimrod\n\nOfek\n\nMatan\n\nRotem\n\nMaayan\n\nGuny\n\nElish\n\nShoval"
credits_text[5] = "and final thanks to you for playing my game!\ngood job for finishing it,\nI hope you had fun!"

//rooms
current_room_index = -2;
room_arr = 0;

follow_inst = noone;

obj_transition.spd_var = 3;
save = 1;
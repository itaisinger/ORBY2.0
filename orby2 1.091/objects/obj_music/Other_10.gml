///@description 

//update music
update_ost = function(){
	
	var save_name = string_delete(global.savefile,string_length(global.savefile)-3,4);

	if(string_contain("musicshititaiscreameastereggsecretostarielohadisraelmatanbenny",save_name) or keyboard_check(vk_alt))
	{
		list_ost[|OST.menu] = ost_alt_menu;
		list_ost[|OST.start] = ost_alt_start;
		list_ost[|OST.pit] = ost_alt_pit;
		list_ost[|OST.purple] = ost_alt_purple;
		list_ost[|OST.orange] = ost_alt_orange;
		list_ost[|OST.dark] = ost_alt_dark;
		list_ost[|OST.underground] = ost_alt_underground;
		list_ost[|OST.capital] = ost_alt_capital;
		list_ost[|OST.capital_2] = ost_alt_capital_2;
		list_ost[|OST.king] = ost_alt_king;
		list_ost[|OST.king2] = ost_alt_king2;
		list_ost[|OST.turn] = ost_alt_turn;
		list_ost[|OST.fall] = ost_alt_fall;
		list_ost[|OST.credits] = ost_alt_credits;
		list_ost[|OST.homeland] = ost_alt_homeland;
		list_ost[|OST.pink] = ost_alt_pink;
	}
	else
	{
		list_ost[|OST.menu] = ost_menu;
		list_ost[|OST.start] = ost_start;
		list_ost[|OST.pit] = ost_pit;
		list_ost[|OST.purple] = ost_purple;
		list_ost[|OST.orange] = ost_orange;
		list_ost[|OST.dark] = ost_dark;
		list_ost[|OST.underground] = ost_underground;
		list_ost[|OST.capital] = ost_capital;
		list_ost[|OST.capital_2] = ost_capital_2;
		list_ost[|OST.king] = ost_king;
		list_ost[|OST.king2] = ost_king2;
		list_ost[|OST.turn] = ost_turn;
		list_ost[|OST.fall] = ost_fall;
		list_ost[|OST.credits] = ost_credits;
		list_ost[|OST.homeland] = ost_homeland;
		list_ost[|OST.pink] = ost_pink;
		list_ost[|OST.nostlagia] = ost_nostlagia;
	}
}

pause_ost  = function(){
	for(var i=0; i<ds_list_size(list_sound_ids); i++)
	{
		audio_pause_sound(list_sound_ids[|i]);
	}
}
resume_ost = function(){
	for(var i=0; i<ds_list_size(list_sound_ids); i++)
	{
		audio_resume_sound(list_sound_ids[|i]);
	}
}
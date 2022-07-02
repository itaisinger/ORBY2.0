

enum OST{
	start,
	pit,
	purple,
	orange,
	dark,
	capital,
	capital_2,
	underground,
	homeland,
	nostlagia,
	pink,
	pink_2,
	none,
	menu,
	fall,
	king,
	king2,
	turn,
	credits,
}

list_sound_ids = ds_list_create();

list_ost = ds_list_create();
current_song = list_ost[|OST.none];


event_user(0); //setup functions
global.music_volume = 1;
global.music_volume_amp = 1;
nos_vol = 0; //nostalgia volume
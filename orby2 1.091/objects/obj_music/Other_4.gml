#region ost by room

switch(room)
{
	case rm_menu: current_song = list_ost[|OST.menu]; break;
	
	case rm_level_1: current_song = list_ost[|OST.start]; break;
	case rm_level_2: current_song = list_ost[|OST.start]; break;
	case rm_level_3: current_song = list_ost[|OST.start]; break;
	case rm_level_4: current_song = list_ost[|OST.start]; break;
	case rm_level_5: current_song = list_ost[|OST.start]; break;
	
	case rm_pit_top:    current_song = list_ost[|OST.pit]; break;
	case rm_pit_middle: current_song = list_ost[|OST.pit]; break;
	case rm_pit_bottom: current_song = list_ost[|OST.pit]; break;
	
	case rm_purple_enter: current_song = list_ost[|OST.purple]; break;
	case rm_purple_top:   current_song = list_ost[|OST.purple]; break;
	case rm_purple_2: current_song = list_ost[|OST.purple]; break;
	case rm_purple_3: current_song = list_ost[|OST.purple]; break;
	case rm_purple_4: current_song = list_ost[|OST.purple]; break;
	case rm_purple_5: current_song = list_ost[|OST.purple]; break;
	case rm_purple_6: current_song = list_ost[|OST.purple]; break;
	case rm_purple_7: current_song = list_ost[|OST.purple]; break;
		
	case rm_orange_1: current_song = list_ost[|OST.orange]; break;
	case rm_orange_2: current_song = list_ost[|OST.orange]; break;
	case rm_orange_3: current_song = list_ost[|OST.orange]; break;
	case rm_orange_4: current_song = list_ost[|OST.orange]; break;
	case rm_orange_5: current_song = list_ost[|OST.orange]; break;
	case rm_orange_6: current_song = list_ost[|OST.orange]; break;
	
	case rm_dark_enter:   current_song = list_ost[|OST.dark]; break;
	case rm_purple_attic: current_song = list_ost[|OST.dark]; break;
	case rm_dark_2: current_song = list_ost[|OST.dark]; break;
	case rm_dark_3: current_song = list_ost[|OST.dark]; break;
	case rm_dark_4: current_song = list_ost[|OST.dark]; break;
	case rm_dark_5: current_song = list_ost[|OST.dark]; break;
	case rm_dark_6: current_song = list_ost[|OST.dark]; break;
	case rm_dark_7: current_song = list_ost[|OST.dark]; break;
	case rm_dark_8: current_song = list_ost[|OST.dark]; break;
	case rm_dark_backdoor: current_song = list_ost[|OST.dark]; break;
	
	case rm_underground_1: current_song = list_ost[|OST.underground]; break;
	case rm_underground_2: current_song = list_ost[|OST.underground]; break;
	case rm_underground_3: current_song = list_ost[|OST.underground]; break;
	case rm_underground_4: current_song = list_ost[|OST.underground]; break;
	
	case rm_blue_1:			    current_song = list_ost[|OST.capital]; break;
	case rm_blue_2:			    current_song = list_ost[|OST.capital]; break;
	case rm_blue_hub:			current_song = list_ost[|OST.capital]; break;
	case rm_blue_hallway:		current_song = list_ost[|OST.capital]; break;
	case rm_blue_hallway2:		current_song = list_ost[|OST.capital]; break;
	case rm_blue_hallway3:		current_song = list_ost[|OST.capital]; break;
	case rm_blue_control_room:  current_song = list_ost[|OST.none]; break;
	case rm_blue_palace:	    current_song = list_ost[|OST.capital]; break;
	case rm_blue_safe:		    current_song = list_ost[|OST.capital]; break;
	case rm_blue_generator:     current_song = list_ost[|OST.capital]; break;
	case rm_blue_exit:		    current_song = list_ost[|OST.capital]; break;
	case rm_blue_hole:          current_song = list_ost[|OST.none]; break;
	case rm_blue_dictionary:    current_song = list_ost[|OST.underground]; break;
	
	case rm_blue_clocktower:    current_song = list_ost[|OST.capital_2]; break;
	case rm_blue_clocktower2:   current_song = list_ost[|OST.capital_2]; break;
	
	case rm_ravine_1:		current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_2:		current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_3:		current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_4:		current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_5:		current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_bottom:	current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_exit:	current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_floor:	current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_pillar:	current_song = list_ost[|OST.homeland]; break;
	case rm_ravine_roof:	current_song = list_ost[|OST.homeland]; break;
	
	case rm_ravine_temple:	current_song = list_ost[|OST.nostlagia]; break;
	
	case rm_pink_1:			current_song = list_ost[|OST.pink]; break;
	case rm_pink_2:			current_song = list_ost[|OST.pink]; break;
	case rm_pink_3:			current_song = list_ost[|OST.pink]; break;
	case rm_pink_4:			current_song = list_ost[|OST.pink]; break;
	case rm_pink_descent:	current_song = list_ost[|OST.pink]; break;
	case rm_pink_double:	current_song = list_ost[|OST.pink]; break;
	case rm_pink_hub:		current_song = list_ost[|OST.pink]; break;
	case rm_pink_ladder:	current_song = list_ost[|OST.pink]; break;
	case rm_pink_run:		current_song = list_ost[|OST.pink]; break;
	case rm_pink_stairs:	current_song = list_ost[|OST.pink]; break;
	case rm_pink_stairs_2:	current_song = list_ost[|OST.pink]; break;
	case rm_pink_stroll:	current_song = list_ost[|OST.pink]; break;
	case rm_pink_exit:		current_song = list_ost[|OST.pink]; break;
}

#endregion
global.music_volume_amp = 1;
nos_vol = 1;
///@description detruction miners

alarm[0] = random_range(room_speed*0.5,room_speed*5)

if(!got_endings[|ENDINGS.destruction]) exit;

create_menu_miner();
if(instance_number(obj_game) > 1)
{
	instance_destroy();
	show_debug_message("more than 1 game object");
	exit;
}

#region enums

enum DEPTH{
	trans       = -500,
	ui_opening_scene = -800,
	ui_game	    = -500,
	menu_orb	= -270,
	darkness	= -265,
	mouse		= -260,
	orb			= -250,
	ui_text		= -210,
	ui_base	    = -200,
	text_top    = -190,
	darkness_pause	= -100,
	lamp		=  100,
	wall_orb	=  104,
	wall_block  =  105,
	spike       =  110,
	orb_unlock  = -30,
	player_eye  = -10,
	wall_fake   =  90,
	pickup      =  106,
	wall		=  120,
	player		=  105,
	anvil		=  92,
	text		=  110,
	body		=  107,
	orb_npc		=  106,
	shadow      =  200,
}

enum GUI_DEPTH{
	trans =  0,
	clock = -10,
}

enum GAME_EVENTS{
	load_game,
	new_game,
	quit_game,
	load_checkpoint,
}

enum CUTSCENES{
	start,
	fall1,
	fall2,
	fall3,
	right_click,
	purple4,
	purple1,
	multijump,
	anchor_camera,
	platform_display,
	light,
	blue1,
	turnover,
	turnover_capital,
	kinghood,
	trailer,
	escape,
	reward1,
	reward2,
	reward3,
	reward4,
	reward5,
	destruction,
	pink_hub,
}

enum WEIGHTS{
	player = 0.1,
	player_anvil = 0.15,
	anvil  = 1,
}

enum SOUND{
	sfx = 0,
	music = 10,
}

//creation num for costum orb unlocks that need it
enum REWARD_ID{
	reward1 = 1000,
	reward2 = 1001,
	reward3 = 1002,
	reward4 = 1003,
	reward5 = 1004,
}

enum REWARD_COLOR{
	reward1 = ORB_STATES.orange,
	reward2 = ORB_STATES.yellow,
	reward3 = ORB_STATES.purple,
	reward4 = ORB_STATES.green,
	reward5 = ORB_STATES.pink,
}

#endregion

depth = DEPTH.wall+1; //refer to the guide
global.version = "1.103";

//game save data
savefile_name = "save";
if(!variable_global_exists("savefile"))
{
	global.savefile  = savefile_name + ".sav";  //main savefile
	global.savefile2 = savefile_name + "2.sav"; //saves just the checkpoints currently have
	global.savefile3 = savefile_name + "3.sav"; //user created checkpoint
	global.savefile4 = savefile_name + "4.sav"; //user created checkpoint after moving a room
}

//last save
global.savefile_last = "lastsave.sav";
if(file_exists(global.savefile_last))
{
	var map = load_JSON_from_file(global.savefile_last)
	
	var newname = map[?"name"];
	
	global.savefile  = newname + ".sav";
	global.savefile2 = newname + "2.sav";
	global.savefile3 = newname + "3.sav";
	global.savefile4 = newname + "4.sav";
	
	ds_map_destroy(map);
}

//progresion vars
list_pressed_keys			= ds_list_create(); //the first var isnt in use.
list_played_scenes			= ds_list_create();
list_placed_anvils			= ds_list_create(); //a list of anvil id's that are placed on the button
list_placed_anvils_x		= ds_list_create(); //list of the placed anvils's x
map_pressed_keys_by_room    = ds_map_create();  //pressed keys by room.
list_got_endings			= ds_list_create(); //list of endings achieved
energy_deposited			= 0;
map_picked_orbs				= ds_map_create();
map_disabled_distruptors	= ds_map_create();

/*/
theres a map of a copy of list_pressed_keys for every room. it updates every room start to 
"let the room know" what happended while he was away. 
before updating, it call event_user0 for every wall block, in which it is destroyed if the room
already knows its supposed to be destroyed.
/*/

//game control vars
death_cnt = 0; //count a second after the player is dead to restart game.
save_game = 0; //if true, saves at the start of the room. used to prevent saving when loading the game.
global.max_capitals = 10;
global.shadow_h = 1;
global.speedrun_active = 0;
global.miner_saved = 0; //if true, spawns a miner saved.
load_anvil_index = -1; //used for saving the anvil when teleporting.
load_flip_anvils = 0; //f me
reward_cost = [5,10,15,20,25]; //cost for deposit rewards
global.light_radius_multi = 1;	//a multiplier for light radius.
#macro RUNTIMES "times.spd"

//flags
global.flag_destruction = 0;	//destruction cutscene has ended.
global.flag_power_plant = 0;	//player has died to the power plant and destroyed it. used to prevent reset.

//wall color
wall_colors[0] = [112/255,112/255,112/255];
wall_colors[1] = [3  /255,126/255,140/255];
wall_colors[3] = [89/255 ,117/255,128/255];
base_color	= shader_get_uniform(sh_wall_color,"base_color");
my_color	= shader_get_uniform(sh_wall_color,"my_color");
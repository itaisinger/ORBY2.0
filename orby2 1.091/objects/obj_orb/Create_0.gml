#region enums

enum COLORS{
	purple,
	orange,
	yellow,
	blue,
	pink,
	green,
	black,
	gray,	
}

enum ORB_STATES{
	purple,
	orange,
	yellow,
	blue,
	pink,
	green,
	black,
	menu,
}

enum ORB_ANIMS{
	create,
	natural,
	unlocked,
}

enum DRAW_MODES{
	natural,
	rec,
}

enum PLATFORM_STATES{
	natural,
	plaform
}

enum JUMPER_STATES{
	natural,
	flor,
	wall,
}

#endregion
//inputs
key_1    = 0;
key_2    = 0;
key_up   = 0;
key_down = 0;
key_black = 0;
key_purple = 0;
key_orange = 0;
key_yellow = 0;
key_blue = 0;
key_pink = 0;
key_green = 0;
key_anchor = 0;

//vars
state = ORB_STATES.black; //the current color.
state_action = 0;		  //state for orb actions.
state_prev  = 0;		  //saves the current state when entering menu state, to return to later.
xdest = 0;
ydest = 0;
spd_max = 30;  //a cap for the speed.
is_anchored = 0;						   //when true, the orb is stuck in place.
unlocked_colors = ds_list_create();		   //a list of the unlocked colors.
unlocked_colors[| ORB_STATES.black] = 1;   
unlock_list = ds_list_create();		//a queue list for the orbs that are about to be unlocked.
state_changed = 0;

//visuals
current_color = COLORS.black;
radius = 8;
base_radius = 10;
menu_radius = 3;
menu_mode_radius = 40
radius_dest = 10;
draw_colors = get_colors();
draw_s = 1;				//scale multiplyer for draw
menu_active = 0;
state_anim = 0;			//use this to play certain animations.
anim_phase = 0;			//used to code animation with fases.
counter_anim = 0;		//used to count frames in animations.
error_frames = 0;		//if this is not 0, the orb shakes in place.
error_frames_menu = 0;  //if this is not 0, the orb menu shakes in place.
draw_cube  = 1;			//1 = the orb is a cube. 0 = the orb is a circle.
depth = DEPTH.orb;
draw_mode  = 0;				//change this to draw the orb in different modes, used with the enum.
rec_w  = 1;					//the width of the orb when its a cube.
rec_h  = 1;					//the height of the orb when its a cube.
disabled = 0;				//when true, the orb color is gray.
flash_color = COLORS.black;	//use the color index not the rgb
flash_a = 0;				//flash_color will be drawn over the current color in flash_a alpha

//black
list_savepoints    = ds_list_create();	//saves indexes of savepoints pickups.
save_display_sizes = array_create(1,0); //what size to draw each save point use.
follow_inst = noone;
menu_mode = 0;							//when in menu mode, two options appear: create and load.
text_create = noone;
text_load   = noone;
return_value = "";

//messages
message_full = ""			 //the full message aiming to draw
message_current = "";		 //the text to display
message_prev = message_full; //used to reset message_current
message_cd   = 0;			 //delay between message update
message_yoff = 0;

//message queue is done form the messages object.
//this object is used to handle messages, check for stuff then add messages to the queue and send them here.

//purple
platform_max = 1;
platform_current = platform_max;
platform_inst = noone;
platform_display_sizes = array_create(1,0);
platform_current_prev = platform_max;
platform_display_base = 6; //base size for a platform display cube
platform_prev = platform_current;

//orange
jump_amp = 1.35;
jump_ampx = 2;
jump_dir = 1;

//blue
grav_used = 0;
grav_flipped = 0; //saved in savepoints and applied on anvils upon loading.

//yellow
light_remain = 0;
list_lamps = ds_list_create();	//saves instance ids of lamps. they remove themselves when destroying.
light_max = 0;
light_sfx = 0;
intro_length = 1.3
loop_length = 1.7;
total_length = intro_length+loop_length;
light_volume = 0.5;
light_size = 20;
light_menu_coords = array_create(4,0);
//pink
pink_remain = 0;
pink_max = 1;

//green
green_remain = 1;
green_max = 1;
my_miner = noone;

//////functions
function col_distance_to_object(inst){
	
	/*/
	find out to which point of the bbox i am to closest to
	determine angle
	walk until collision
	count distance
	reset to original position
	send distance
	/*/
	
	var _x = x, _y = y; //to reset later
	var _min = 64, _mini, _dis;
	var _points =	[[inst.bbox_bottom,	inst.bbox_right	],
					 [inst.bbox_bottom,	inst.bbox_left	],
					 [inst.bbox_top,	inst.bbox_right	],
					 [inst.bbox_top,	inst.bbox_left	],]
					 
	//loop
	for(var i=0; i < array_length(_points); i++)
	{
		_dis = point_distance(x,y, _points[i][1],_points[i][0]);
		if(_dis < _min)
		{
			_mini = i;
			_min = _dis;
		}
		
	}
	
	//calculate path
	var _a = point_direction(x,y, _points[_mini][1],_points[_mini][0])
	var _xadd = lengthdir_x(1,_a);
	var _yadd = lengthdir_y(1,_a);
	
	//check distance
	_dis = 0;
	while(!place_meeting(x,y,inst))
	{
		_dis++;
		x += _xadd;
		y += _yadd;
	}
	
	//reset pos
	x = _x;
	y = _y;
	
	//send distance
	return _dis;
	
}
function pickup(creation_num){
	
	//visuals
	flash_color = COLORS.black;
	flash_a = 1;
	state_anim = ORB_ANIMS.unlocked;
	
	//logic
	ds_list_add(list_savepoints,creation_num);
	save_savepoints();
}










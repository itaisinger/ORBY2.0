#region save endings

if(save)
{
	save = 0;
	
	obj_speedrun.list_end_times[|end_index] = obj_speedrun.time;
	save_endings();
}

#endregion
#region setup rooms arr

if(current_room_index == -2)
{
	current_room_index = -1;
	room_arr[0] = rm_blue_hub;
	room_arr[1] = rm_orange_3;
	room_arr[2] = rm_pit_top;
	room_arr[3] = rm_purple_3;
	room_arr[4] = rm_pit_middle;
	room_arr[5] = rm_underground_4;
	room_arr[6] = rm_pit_bottom;
	
	transition(TRANS_STATES.goto_credits,room_arr[0],0);
}

#endregion
#region general control

with(obj_orb) platform_current = platform_max;
with(obj_player) is_paused = true;

#endregion
#region follow inst

var _room_over = false;

if(!instance_exists(obj_pause))
with(follow_inst)
{
	//go down
	if(room_height > room_width)
	{
		y += room_height/(room_speed*15)
		
		x = room_width/2;
		
		if(room == rm_orange_3) x -= 350;
		
		if(y > room_height-camera_get_view_height(view_camera[0])/2 + (other.current_room_index+1 == (array_length(other.room_arr)))*2300)
			_room_over = 1;
	}
	//go right
	else
	{
		x += room_width/(room_speed*10)
		y = room_height/2;
		
		if(x > room_width-camera_get_view_width(view_camera[0])/2)
			_room_over = 1;
	}
	
	sprite_index = spr_capital_anvil_v
	
	other.x = x;
	other.y = y;
}


//go to next room
if(instance_exists(follow_inst) and obj_transition.state == TRANS_STATES.off)
if(_room_over)
if(room_arr[current_room_index] == room)
{

	if(current_room_index+1 < array_length(room_arr))
	{
		transition(TRANS_STATES.goto_credits,room_arr[current_room_index+1],0)
		obj_transition.spd_var = 1.8;
	}
	else
	{
		//save the game ending
		transition(TRANS_STATES.menu)
		instance_destroy();
		exit;
	}
}	

#endregion
#region text

//update positions
if(ds_list_size(list_text_insts))
switch(room)
{
	case text_rooms[0]:
	
	var yy = follow_inst.y;
	
	//title
	list_text_insts[|0].y = yy
	list_text_insts[|0].x = follow_inst.x
	list_text_insts[|0].outline_width = 5;
	
	//ending got
	yy += 90;
	list_text_insts[|1].y = yy;
	list_text_insts[|1].x = follow_inst.x
	
	//time
	yy += 40;
	list_text_insts[|2].y = yy;
	list_text_insts[|2].x = follow_inst.x
	
	break;
	////////////
	case text_rooms[1]:

	var yy = follow_inst.y;
	
	//game by itai singer
	list_text_insts[|0].y = clamp(0,yy,room_height*0.7);
	list_text_insts[|0].x = camera_get_view_width(view_camera[0])/2;
	list_text_insts[|0].color = c_black;
	list_text_insts[|0].outline_width = 0;
	
	//soundtrack by matan koresh
	list_text_insts[|1].y = room_height*0.7+80//clamp(room_height/2+280,yy,room_height);
	list_text_insts[|1].x = camera_get_view_width(view_camera[0])/2;
	list_text_insts[|1].color = c_black;
	list_text_insts[|1].outline_width = 0;
	
	break;
	//////////////
	case text_rooms[2]:
	
	//motivational support
	list_text_insts[|0].y = room_height/3;
	list_text_insts[|0].x = camera_get_view_width(view_camera[0])/2;
	list_text_insts[|0].color = list_text_insts[|0].outline_color;
	list_text_insts[|0].outline_width = 0;
	
	//beta testing
	list_text_insts[|1].y = (room_height/3)*2-100;
	list_text_insts[|1].x = camera_get_view_width(view_camera[0])/2;
	list_text_insts[|1].color = list_text_insts[|0].outline_color;
	list_text_insts[|1].outline_width = 0;
	
	break;
	//////////////
	case text_rooms[3]:
	
	follow_inst.y += 1;
	
	//thank you
	list_text_insts[|0].y = room_height - camera_get_view_height(view_camera[0])/2-200;
	list_text_insts[|0].x = camera_get_view_width(view_camera[0])/2;
	list_text_insts[|0].color = list_text_insts[|0].outline_color;
	list_text_insts[|0].outline_width = 0;
	
	if(follow_inst.y > room_height and !instance_exists(obj_orb_miner))
		with(instance_create_depth(room_width/2,0,depth,obj_miner))
		{
			dir = 1;
			state = MINERS.fall;
		}
	
	break;
}

#endregion
#region update colors

var o_col = get_colors(obj_orb.current_color);
var m_col = get_colors_background(obj_orb.current_color);
for(var i=0; i<ds_list_size(list_text_insts); i++)
{
	list_text_insts[|i].outline_width = list_text_insts[|i].scale*3;
	list_text_insts[|i].color = m_col;
	list_text_insts[|i].outline_color = o_col;
	list_text_insts[|i].outline_double = 1;
}

#endregion
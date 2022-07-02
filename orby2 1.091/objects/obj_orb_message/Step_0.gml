if(!instance_exists(obj_orb) or instance_exists(obj_pause) or !instance_exists(obj_player)) exit;
var o = obj_orb;
#region manage messages

//clear the message a second after its finished
if(o.message_full == o.message_current)
{
	if(switch_cd>0) switch_cd--;
	else
	{
		switch_cd = 160;
		o.message_full = "";
	}
}
else switch_cd = 160;

#endregion
#region normal messages

if(!instance_exists(obj_credits))
{
#region no platform left

if(o.message_full == "" or o.message_full == messages_strs[MESSAGES.idle1+last_r])
and(o.platform_current == 0 and !list_played_messages[|MESSAGES.no_platform_uses])
{
	o.message_full = messages_strs[MESSAGES.no_platform_uses];
	list_played_messages[|MESSAGES.no_platform_uses] = true;
}
if(o.platform_current != 0)
{
	if(o.message_full == messages_strs[MESSAGES.no_platform_uses])
		o.message_full = "";
	list_played_messages[|MESSAGES.no_platform_uses] = 0;
}

#endregion
#region disabled

if(o.error_frames>0 and o.disabled)
	o.message_full = messages_strs[MESSAGES.disabled];

disabled_prev = o.disabled
state_action_prev = o.state_action

#endregion
#region high

if(o.state = ORB_STATES.purple and o.state_action == 1)
and(obj_player.ground and place_meeting(obj_player.x,obj_player.y+1,o))  
{
	if(!list_played_messages[|MESSAGES.high])
	{
		if(high_cd>0) high_cd--;
		else
		{
			var high = 1;
			var wall = noone;
			for(var yy = 0; yy<obj_player.sprite_height*15; yy += 4)
			{
				wall = instance_place(o.x,o.y+yy,obj_wall);
				if(wall != noone and wall != o.platform_inst)
					high = 0;
			}
	
			if(high)
			{
				var r = random(10)
				if(r >= 5)
					o.message_full = messages_strs[MESSAGES.high];
				list_played_messages[|MESSAGES.high] = true;
			}
		}
	}
}
else
{
	high_cd = 40;
	if(place_meeting(obj_player.x,obj_player.y+1,obj_wall))
 	list_played_messages[|MESSAGES.high] = false;
	
	//remove the msg
	if(o.message_full == messages_strs[MESSAGES.high])
		o.message_full = "";
}



#endregion
#region idle

var p = obj_player;
if(p.key_down+p.key_up+p.key_left+p.key_right+p.vsp + o.key_1+o.key_2 == 0 and !instance_exists(obj_credits))
{
	if(o.message_full == "")
	{	
		last_r = irandom(4+(instance_exists(obj_darkness) and obj_orb.state != ORB_STATES.yellow));
		o.message_full = messages_strs[MESSAGES.idle1+last_r];
	}
}
else if(o.message_full == messages_strs[MESSAGES.idle1+last_r])
	o.message_full = "";

#endregion
#region stuck

with(o)
{
	if(place_meeting(x,y,obj_orb_solid))
		message_full = other.messages_strs[MESSAGES.stuck];
}

#endregion
#region keyboard

if(o.key_2 and o.message_full == "" and ds_list_size(o.unlocked_colors)>1)
{
	if(irandom(keyboard_notice) == 2)
	{
		o.message_full = messages_strs[MESSAGES.keyboard];
		keyboard_notice += 2;
	}
}


#endregion
#region death

if(death_r == -1 and obj_player.killer != noone)
{
	death_r = irandom(20-17*(o.message_current != ""));
	if(death_r < 4)
		o.message_full = messages_strs[MESSAGES.death1+death_r];
	
}

#endregion
#region yellow disruptor

/*/
if the orb's state is yellow and there is a disruptor and the message is unplayed, play it.
/*/
var _yellow = 0;
with(obj_disruptor) if(index == ORB_STATES.yellow and active and alarm[0] == 0)
	_yellow = 1;

if(o.state == ORB_STATES.yellow and _yellow)
{
	o.message_full = messages_strs[MESSAGES.disruptor_yellow];
}


#endregion
}

#endregion
#region special messages

//by room
switch(room)
{
	#region hi there
	case rm_level_1:
	
	if(!list_played_messages[|MESSAGES.hello] and obj_player.ground and obj_player.y > 10)
	{
		o.message_full = messages_strs[MESSAGES.hello];
		list_played_messages[|MESSAGES.hello] = 1;
	}
	
	break;
	#endregion
	#region where are we going?
	
	case rm_level_2:
	
	if(!list_played_messages[|MESSAGES.where])
	{
		o.message_full = messages_strs[MESSAGES.where];
		list_played_messages[|MESSAGES.where] = 1;
	}
	break;
	
	#endregion
	#region deep
	
	case rm_level_5:
	
	if(!list_played_messages[|MESSAGES.deep] and abs(obj_player.x-obj_trigger.x)< 200)
	{
		o.message_full = messages_strs[MESSAGES.deep];
		//list_played_messages[|MESSAGES.deep] = 1;
	}
	break;
	
	#endregion
	#region fall
	
	case rm_pit_top:
	
	if(!list_played_messages[|MESSAGES.fall])
	{
		o.message_full = messages_strs[MESSAGES.fall];
		list_played_messages[|MESSAGES.fall] = 1;
	}
	break;
	//////////////
	case rm_pit_middle:
	
	if(!list_played_messages[|MESSAGES.fall2])
	{
		o.message_current = "";
		o.message_full = messages_strs[MESSAGES.fall];
		list_played_messages[|MESSAGES.fall2] = 1;
	}
	break;
	//////////////
	case rm_pit_bottom:
	
	if(!list_played_messages[|MESSAGES.fall3])
	{
		o.message_current = "";
		o.message_full = messages_strs[MESSAGES.fall];
		list_played_messages[|MESSAGES.fall3] = 1;
	}
	break;
	//////////////
	
	#endregion
	#region more orbs
	
	case rm_blue_lab:
		if(!list_played_messages[|MESSAGES.more_orbs])
		{
			o.message_full = messages_strs[MESSAGES.more_orbs];
			list_played_messages[|MESSAGES.more_orbs] = 1;
		}
		else if(!list_played_messages[|MESSAGES.more_orbs2] and o.message_full == "")
		{
			o.message_full = messages_strs[MESSAGES.more_orbs2];
			list_played_messages[|MESSAGES.more_orbs2] = 1;
		}
		
	break;
	
	#endregion
	#region drawings
	
	case rm_blue_hole:
	
	if(o.state == ORB_STATES.yellow and !list_played_messages[|MESSAGES.drawings])
	{
		o.message_full = messages_strs[MESSAGES.drawings];
		list_played_messages[|MESSAGES.drawings] = true;
	}
	
	break;
	
	#endregion
	#region yoshi
	
	case rm_blue_clocktower2:
	
	if(instance_exists(obj_player))
	if(place_meeting(obj_player.x,obj_player.y,obj_trigger) and 1)//list_played_messages[|MESSAGES.yoshi]
	{
		o.message_full = messages_strs[MESSAGES.yoshi];
		list_played_messages[|MESSAGES.yoshi] = true;
	}
	
	break;
	
	#endregion
}

#region end
if(instance_exists(obj_credits))
switch(obj_credits.end_index)
{
	case ENDINGS.escape:
	if(!list_played_messages[|MESSAGES.end_escape])
	{
		o.message_full = messages_strs[MESSAGES.end_escape];
		list_played_messages[|MESSAGES.end_escape] = 1;
	}
	break;
	//////////
	case ENDINGS.turnover:
	if(!list_played_messages[|MESSAGES.end_turnover])
	{
		o.message_full = messages_strs[MESSAGES.end_turnover];
		list_played_messages[|MESSAGES.end_turnover] = 1;
	}
	break;
	//////////
	case ENDINGS.kinghood:
	if(!list_played_messages[|MESSAGES.end_kinghood])
	{
		o.message_full = messages_strs[MESSAGES.end_kinghood];
		list_played_messages[|MESSAGES.end_kinghood] = 1;
	}
	break;
	//////////
	case ENDINGS.obedience:
	if(!list_played_messages[|MESSAGES.end_obedience])
	{
		o.message_full = messages_strs[MESSAGES.end_obedience];
		list_played_messages[|MESSAGES.end_obedience] = 1;
	}
	break;
	//////////
	case ENDINGS.destruction:
	if(!list_played_messages[|MESSAGES.end_destruction])
	{
		o.message_full = messages_strs[MESSAGES.end_destruction];
		list_played_messages[|MESSAGES.end_destruction] = 1;
	}
	break;
	//////////
}
#endregion

//various
#region savepoint pickup 

if(ds_list_size(o.list_savepoints) and !list_played_messages[|MESSAGES.savepoint_pickup])
{
	o.message_full = messages_strs[MESSAGES.savepoint_pickup];
	list_played_messages[|MESSAGES.savepoint_pickup] = true;
}

#endregion
#region savepoint used

if(instance_exists(obj_spawn) and !list_played_messages[|MESSAGES.savepoint_used])
{
	o.message_full = messages_strs[MESSAGES.savepoint_used];
	list_played_messages[|MESSAGES.savepoint_used] = true;
}

#endregion
#region unlock

if(instance_exists(obj_cutscene))
if(obj_cutscene.index == CUTSCENES.right_click)
{
	var msg = "";
	switch(obj_cutscene.stage)
	{
		case 1: msg = messages_strs[MESSAGES.switch_color];  break;
		case 2: msg = messages_strs[MESSAGES.switch_color2]; break;
		case 3: msg = messages_strs[MESSAGES.switch_color3]; break;
		case 4: msg = ""; break;
	}
	
	
	
	if(o.message_full != msg)
	{
		o.message_full = msg;
	}
}

//if(list_sum(o.unlocked_colors) > 1 and !list_played_messages[|MESSAGES.unlock])
//and(!o.menu_active and o.message_full != messages_strs[MESSAGES.unlock])
//{
//	o.message_full = messages_strs[MESSAGES.unlock];
//}

//if(o.menu_active)				list_played_messages[|MESSAGES.unlock]		 = true;
//if(o.state != ORB_STATES.black) 
//{
//	list_played_messages[|MESSAGES.switch_color] = true;
//	list_played_messages[|MESSAGES.unlock]		 = true;
	
//	if(o.message_full == messages_strs[MESSAGES.unlock])
//	or(o.message_full == messages_strs[MESSAGES.switch_color])
//		o.message_full = "";
//}

#endregion

//cancel triggers
#region switch color

if(o.message_full == messages_strs[MESSAGES.switch_color])
and(o.state == ORB_STATES.purple and !list_played_messages[|MESSAGES.switch_color])
{
	list_played_messages[|MESSAGES.switch_color] = true;
	o.message_full = "";
}
#endregion
#region deep

if(o.message_current == messages_strs[MESSAGES.deep])
{
	list_played_messages[|MESSAGES.deep] = 1;
}
if(room == rm_pit_top)
{
	if(o.message_full == messages_strs[MESSAGES.deep])
	{
		list_played_messages[|MESSAGES.deep] = 1;
		o.message_full = "";
	}
}

#endregion
#region switch color

if(o.state != ORB_STATES.black)
	list_played_messages[|MESSAGES.switch_color] = true;

#endregion
#region fall

if(obj_player.ground and o.message_full == messages_strs[MESSAGES.fall])
	o.message_full = "";

#endregion

#endregion
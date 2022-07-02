///@description 
switch(index)
{
	#region start
	
	case CUTSCENES.start:
	
	#region destroy top exits
		
	//destroy the top exit
	var ex = noone;
	for(var i=0; i<instance_number(obj_exit); i++)
	{
		ex = instance_find(obj_exit,i);
		if(ex != noone)
		if(ex.room_dest == rm_blue_1)
			instance_destroy(ex);
	}
		
	#endregion
	#region locate scene parts
	
	var trigger_close = noone;
	var trigger_open = noone;
	var trigger_mouse1 = noone;
	var trigger_move = noone;
	var trigger_wall_l = noone;
	var trigger_wall_r = noone;
	var trigger_orb = noone;
	var wall_inst = noone;
	var trigger_button = noone;
		
	for(var i=0; i < instance_number(obj_trigger); i++)
	{
		var inst = instance_find(obj_trigger,i);
		
		switch(inst.index)
		{
			case "closed": trigger_close  = inst; break;
			case "open"  : trigger_open   = inst; break;
			case "mouse1": trigger_mouse1 = inst; break;
			case "move"  : trigger_move   = inst; break;
			case "wall open left":  trigger_wall_l = inst; break;
			case "wall open right": trigger_wall_r = inst; break;
			case "orb"  : trigger_orb = inst; break;
			case "button"  : trigger_button = inst; break;
			case "locate": wall_inst = instance_place(inst.x,inst.y,obj_wall); break;
		}
	}
		
	if(!instance_exists(obj_create_button))
	{
		with instance_create_depth(trigger_button.x,trigger_button.y,depth,obj_create_button)
		{
			font = font_ui;
			outline_width = 3;
		}
	}
	
	#endregion
	#region play scene
	
	switch(stage)
	{
		case 0: //the mouse sprite comes on screen and the player presses mouse1
	
		if(!instance_exists(obj_orb_create_mouse)) 
			instance_create_depth(trigger_orb.x,-200,depth,obj_orb_create_mouse);
		
		var inst = instance_find(obj_orb_create_mouse,0);
		
		if(abs(inst.y-trigger_orb.y) > 5)
			inst.y = lerp(inst.y,trigger_orb.y,0.1);
		inst.x = trigger_orb.x;
		
		if(instance_exists(obj_orb))
			stage++;
			
		break;
		//////////////////
		case 1: //the mouse flies up and the player presses the create button
		
		//send mouse preview up
		var inst = instance_find(obj_orb_create_mouse,0);
		inst.y = approach(inst.y,spd,-200);
		spd += 0.5;
		
		//idle message
		with(obj_orb_message)
		{
			if(obj_orb.message_full != messages_strs[MESSAGES.idle_start])
				obj_orb.message_full = messages_strs[MESSAGES.idle_start];
		}
		
		with(obj_orb)
		{
			menu_mode = 0;
			instance_destroy(text_create);
			instance_destroy(text_load);
			if(message_full != obj_orb_message.messages_strs[MESSAGES.hello]
			and message_full != obj_orb_message.messages_strs[MESSAGES.idle_start])
				message_full = "";
		}
		
		//proceed to the next stage
		if(instance_exists(obj_player))
		if(obj_player.ground and obj_player.y>10)
			stage++;
		
		//the stage moves on from the button obj
		break;
		//////////////////
		case 2: //the walls close and the text floats in
		
		if(text_inst  == noone) text_inst  = instance_create_depth(trigger_move.x,-200,depth,obj_text)
		
		with(text_inst)
		{
			if(obj_input.bind_left == ord("A"))
			     text = "move with awsd\njump with space";
			else text = "move with arrow keys\njump with up";
		}
		
		text_inst.y = lerp(text_inst.y,trigger_move.y,0.1);
		
		break;
	}

	#endregion
	
	break;
	
	#endregion
	#region fall
	
	case CUTSCENES.fall1:
		
		obj_input.orb_active = 0;
		
		//draw bars
		draw_bars = 1;
		
		//prevent control
		if(instance_exists(obj_player))
		{
			obj_player.has_control = false;
			obj_player.draw_xs = 1;
			obj_player.draw_ys = 1;
			
			//make it a bit slow
			obj_player.vsp = clamp(obj_player.vsp,-22,22);
		}
		
		instance_destroy(obj_miner_spawner);
	
	break;
	///////////////////////////
	case CUTSCENES.fall2:
		
		instance_destroy(obj_miner_spawner);
		obj_input.orb_active = 0;
		
		//draw bars
		draw_bars = 1;
		
		//text
		if(text_inst == noone)
			text_inst = instance_create_depth(0,0,0,obj_text);
		
		//prevent control
		if(instance_exists(obj_player))
		{
			obj_player.has_control = false;
			obj_player.draw_xs = 1;
			obj_player.draw_ys = 1;
			
			//make it a bit slow
			obj_player.vsp = clamp(obj_player.vsp,-22,22);
		}
		
		with(text_inst)
		{
			y = obj_player.y + 42;
			x = obj_player.x + 50//camera_get_view_width(view_camera[0])/2 + 50;
			y = clamp(y,camera_get_view_height(view_camera[0])+string_height(text),room_height-camera_get_view_height(view_camera[0]));
			
			halign = fa_left;
			valign = fa_bottom;
			
			text = "a game by\nitai singer";
			scale = 1;
			
			depth = DEPTH.ui_text;
		}
	break;
	/////////////////////////
	case CUTSCENES.fall3:
	
		var _record = 0;
		instance_destroy(obj_miner_spawner);
		obj_input.orb_active = 0;
		
		//draw bars
		draw_bars = 1;
		
		//text
		if(text_inst == noone)
			text_inst = instance_create_depth(0,0,0,obj_text);
		
		//prevent control
		if(instance_exists(obj_player))
		{
			obj_player.has_control = false;
			obj_player.draw_xs = 1;
			obj_player.draw_ys = 1;
			
			//make it a bit slow
			obj_player.vsp = clamp(obj_player.vsp,-22,22);
		
			if(obj_player.ground) //exit
			{
				obj_player.has_control = true;
				obj_input.orb_active = true;
				with(obj_music) current_song = list_ost[|OST.pit];
				destroy = true;
				index = -1;
				done = 1;
				with(obj_saveload) event_user(SAVELOAD.save);
				instance_destroy(text_inst);
			}
		}
		
		with(text_inst)
		{
			x = obj_player.x;
			y = obj_camera.y + 400;
			
			if(_record)
				y = clamp(y,200,room_height-500);
			else
				y = clamp(y,200,room_height-camera_get_view_height(view_camera[0])-400);
				
			depth = DEPTH.ui_text;
			
			halign = fa_center;
			valign = fa_bottom;
			
			text = "ORBY 2.0";
			color = c_white;
			outline_color = c_black;
			outline_width = 5;
			scale = 3;
		}
	break;
	
	#endregion
	#region trailer
	case CUTSCENES.trailer:
	
	//prevent control
	if(instance_exists(obj_player))
	{
		//obj_player.has_control = false;
			
		//make it a bit slow
		obj_player.vsp = clamp(obj_player.vsp,-24,24);
	}
	
	//vars
	var hp = room_height/100;
	
	//text
	if(text_inst == noone)
		text_inst = instance_create_depth(0,0,0,obj_text);
	if(text_inst2 == noone and obj_player.ground)
		text_inst2 = instance_create_depth(0,hp*10,0,obj_text);
	if(text_inst3 == noone and obj_player.ground)
		text_inst3 = instance_create_depth(0,hp*10,0,obj_text);
	
	//made by itai singer
	with(text_inst)
	{
		y = obj_player.y + 42;
		x = obj_player.x + 50;
		y = clamp(y,hp*30,hp*75);
		
		halign = fa_left;
		valign = fa_bottom;
			
		text = "a game by\nitai singer";
		scale = 1;
		
		depth = DEPTH.ui_text;
	}
	
	//orby 2
	with(text_inst2)
	{
		x = room_width/2	
		y = lerp(y,room_height-420,0.05);
		
		depth = DEPTH.ui_text;
			
		halign = fa_center;
		valign = fa_bottom;
		
		text = "ORBY 2.0";
		color = c_white;
		outline_color = c_black;
		outline_width = 5;
		scale = 3;
	}
	
	//out now!
	with(text_inst3)
	{
		x = room_width/2;		
		y = lerp(y,room_height-560,0.02);
				
		depth = DEPTH.ui_text;
			
		halign = fa_center;
		valign = fa_top;
		
		text = "out now!";
		color = c_white;
		outline_color = c_black;
		outline_width = 3;
		scale = 1;
	}
	
	break;
	#endregion
	#region right click
	
	case CUTSCENES.right_click:
	
	switch(stage)
	{
		#region pickup
		
		case 0:
		
		//find spot
		trigger_spot = instance_find(obj_trigger,1);
		if(text_inst == noone)
			text_inst = instance_create_depth(0,-200,DEPTH.ui_text,obj_sprite);
		
		if(instance_exists(obj_orb_unlock))
		{
			if(obj_orb_unlock.state == UNLOCK_STATES.off) //start
			{
				stage++;
			}
		}
		
		break;
		
		#endregion
		#region right click
		case 1:
		
		with(text_inst)
		{
			sprite_index = spr_right_click;
			depth = DEPTH.ui_text;
			size = 4;
				
			y = lerp(y,other.trigger_spot.y,0.1);	
			x = other.trigger_spot.x;
		}
		
		//continue with the scene
		if(obj_orb.menu_active)
			stage++;
			
		break;
		#endregion
		#region scroll
		
		case 2:
		
		with(text_inst)
		{
			image_index = 1;
			y = lerp(y,other.trigger_spot.y,0.1);
		}
		if(obj_orb.state != ORB_STATES.black)
			stage++;
		
		break;
		
		#endregion
		#region left click
		
		case 3:
		
		with(text_inst)
		{
			image_index = 2;
			y = lerp(y,other.trigger_spot.y,0.1);
		}
		
		if(obj_orb.state_action != 0)
		{
			stage++;
			obj_game.list_played_scenes[|CUTSCENES.right_click] = true;
		}
		
		break;
		#region fade out
		
		case 4:
		text_inst.y = lerp(text_inst.y,-200,0.1);
		break;
		
		#endregion
		
		#endregion
	}

	break;
	
	#endregion
	#region camera anchor
	
	case CUTSCENES.anchor_camera:
	
	if(text_inst == noone)
		text_inst = instance_create_depth(obj_player.x,-400,DEPTH.ui_text,obj_text);
		
	with(text_inst)
	{
		text = "press mouse wheel or shift to anchor the camera in place.\nuse this when lining up platform placement.";
		
		halign = fa_left;
		valign = fa_top;
		
		depth = DEPTH.ui_text;
		x = clamp(obj_camera.x + 50, 100, room_width/2-string_width(text));
		y = lerp(y,other.ydest,0.1);
	}
	
	//end
	if(abs(obj_player.x - room_width/2) < 50)
	{
		ydest = -300;
		obj_game.list_played_scenes[|CUTSCENES.anchor_camera] = true;
	}
	
	break;
	
	#endregion
	#region platform display
	
	case CUTSCENES.platform_display:

	if(text_inst == noone)
	{
		text_inst = instance_create_depth(room_width/2,-300,DEPTH.text,obj_text);
		with (text_inst)
		{
			text = "you can recreate your platform multipile times to catch yourself midair.\n"
			text += "to catch yourself easily, lead with your mouse to the next position.\n"
			text += "platform uses remaining is displayed left to your orb by purple\\gray cubes";
			
			halign = fa_center;
			valign = fa_middle;
	
			scale = 0.7;
		}
	}
		
	with(text_inst)
	{	
		y = lerp(y,room_height/2-100,0.1);
	}
	
	break;
	
	#endregion
	#region multijump
	case CUTSCENES.multijump:
	
	with(obj_miner)
	{
		eyeout_index = 0;
		eye_a = 45;
		eye_scale = 1.1;
	}
	break;
	#endregion
	#region light
	
	case CUTSCENES.light:
	
	if(instance_exists(obj_orb))
	if(obj_orb.state == ORB_STATES.yellow)
	{
		global.camera_zoom = 1;
		obj_game.list_played_scenes[|index] = 1;
		done = 1;
		destroy = 1;
	}
	
	break;
	
	#endregion
	#region blue1
	case CUTSCENES.blue1: 
	
	if(obj_game.list_pressed_keys[|4])
		instance_destroy(obj_camera_border);
	
	break;
	#endregion
	#region turover
	case CUTSCENES.turnover:
	
	if(!instance_exists(obj_pause))
	with(obj_player)
	{
		var end_precent = 1.2;
		
		if(instance_exists(obj_king) and place_meeting(x,y,obj_camera_border) and other.stage == 0)
		{
			#region setup vars and reference points
			
			obj_speedrun.reached_ending = 1;
			var curve = animcurve_get(cur_turnover);
			var channel = animcurve_get_channel(curve,"capital");
			
			var turn_start = channel.points[1].posx;
			var body_end = channel.points[2].posx;
			var turn_end = channel.points[3].posx;
			
			//turnover
			var increase = 0.0005;
			increase *= 2;
			if(turned_precent > turn_end) increase *= 0.5;
			turned_precent = approach(turned_precent,increase,end_precent);
			
			#endregion
			#region player movement
			
			//push to point
			var pxdest = obj_trigger.x;
			var momx = (pxdest-x)/10;
			
			var channel = animcurve_get_channel(curve,"pull_force");
			var force = animcurve_channel_evaluate(channel,turned_precent);
			momentum_x = momx*force;
			
			//float
			if(turned_precent > turn_start and !is_capital)
			{
				y = approach(y,3, obj_trigger.y+wave(-10,10,2,0)); 
				grav = 0;
			}
			
			#endregion
			#region eye turn
			
			draw_eye = 1;
			var lay_id = layer_get_id("seq");
			if(turned_precent > body_end and turned_precent < turn_end)
			{
				draw_eye = 0;
				draw_xs = 1;
				draw_ys = 1;
				
				//create the sequence
				if(other.my_seq == -1)//!layer_sequence_exists(lay_id,other.my_seq))
				{
					other.my_seq = layer_sequence_create(lay_id,x,y-sprite_height/2,seq_turnover);

					var _speed = 0.6*(increase/0.001)
					_speed *= 1.2;
					layer_sequence_speedscale(other.my_seq,_speed);
				}
				//tweek the position
				else
				{
					layer_sequence_y(other.my_seq,y-sprite_height/2)
					layer_sequence_x(other.my_seq,x)
				}
			}
			//destroy the sequence after the finish of the eye animation period
			else
			{
				if(layer_sequence_is_finished(other.my_seq))
					layer_sequence_destroy(other.my_seq);
			}
			
			
			#endregion
			#region player bow
			
			if(turned_precent > turn_end+0.05)
			{
				bow = 1;
			}
			
			#endregion
			#region orb messages
			with(obj_orb_message)
			{
				//delete non relevent messages
				var msg = obj_orb.message_full;
				if(msg != "" and msg != messages_strs[MESSAGES.turnover1] and msg != messages_strs[MESSAGES.turnover2])
					obj_orb.message_full = "";
				
				//reset msgs played
				if(other.turned_precent < turn_start)
				{
					list_played_messages[|MESSAGES.turnover1] = false;
					list_played_messages[|MESSAGES.turnover2] = false;
				}
				
				//first message
				if(other.turned_precent > turn_start+0.05)
				if(!list_played_messages[|MESSAGES.turnover1])
				{
					obj_orb.message_full = messages_strs[MESSAGES.turnover1];
					list_played_messages[|MESSAGES.turnover1] = true;
				}
				
				//second message
				if(other.turned_precent > turn_end-0.05)
				if(!list_played_messages[|MESSAGES.turnover2])
				{
					obj_orb.message_full = messages_strs[MESSAGES.turnover2];
					list_played_messages[|MESSAGES.turnover2] = true;
				}
			}
			
			#endregion
			#region camera
			
			//zoom
			var channel = animcurve_get_channel(curve,"zoom");

			global.camera_zoom = animcurve_channel_evaluate(channel,turned_precent);
			
			//add shake
			if(turned_precent%0.1 == 0)
				global.camera_shake = turned_precent*2;
			
			#endregion
			#region extra details
			
			if(turned_precent > turn_start)
				obj_king.look_at_me = 1;;
			
			#endregion
			
			//detect player turnover finish
			if(turned_precent >= turn_end and !is_capital)
			{
				is_capital = 1;
				momentum_y -= 10;
			}
			
			//end scene
			if(turned_precent >= end_precent)
			{
				other.stage = 1;
				obj_game.list_got_endings[|ENDINGS.turnover] = true;
				
				if(obj_transition.state == TRANS_STATES.off)
				{
					with instance_create_depth(0,0,0,obj_credits)
					{
						end_index = ENDINGS.turnover;
					}
				}
			}
			
			//disable non relevent features
			obj_orb.menu_mode = 0;
			instance_destroy(look_inst);		
		}
		else
		//negate effects when scene os over/hasnt started
		{
			turned_precent = approach(turned_precent,0.02,0);
			if(!is_capital)
				global.camera_zoom = 1.1;
								
			with(obj_king) look_at_me = 0;
			
			/////////////////////////////////////////////////
			
			//detect transition to kinghood
			if(!instance_exists(obj_king))
			{
				other.index = CUTSCENES.kinghood;
			}
			
			////////////////////////////////////////////////
		}
	}
	
	
	break;
	#endregion
	#region turnover capital
	case CUTSCENES.turnover_capital:
	
	if(!instance_exists(obj_pause))
	with(obj_player)
	{
		var end_precent = 1.2;
		
		if(place_meeting(x,y,obj_camera_border) and other.stage == 0)
		{
			#region setup vars and reference points
			
			obj_speedrun.reached_ending = 1;
			var curve = animcurve_get(cur_turnover);
			var channel = animcurve_get_channel(curve,"capital");
			
			var turn_start = channel.points[1].posx;
			var body_end = channel.points[2].posx;
			var turn_end = channel.points[3].posx;
			
			//turnover
			var increase = 0.0005;
			increase *= 5;
			if(turned_precent > turn_end) increase *= 0.5;
			turned_precent = approach(turned_precent,increase,end_precent);
			
			#endregion
			#region player movement
			
			//push to point
			var pxdest = obj_trigger.x;
			var momx = (pxdest-x)/10;
			
			var channel = animcurve_get_channel(curve,"pull_force");
			var force = animcurve_channel_evaluate(channel,turned_precent);
			momentum_x = momx*force;
			
			
			#endregion
			
			//player bow
			if(turned_precent > turn_start+0.05)
				bow = 1;
			
			//zoom
			var channel = animcurve_get_channel(curve,"zoom");
			global.camera_zoom = animcurve_channel_evaluate(channel,0);
			
			//end scene
			if(turned_precent >= end_precent)
			{
				other.stage = 1;
				
				if(obj_transition.state == TRANS_STATES.off)				
					with instance_create_depth(0,0,0,obj_credits)
						end_index = ENDINGS.turnover;
			}
			
			
			
			/////////////////////////////////////////////////
			
			//detect transition to kinghood
			if(!instance_exists(obj_king))
			{
				other.index = CUTSCENES.kinghood;
			}
			
			////////////////////////////////////////////////
			
			
			//disable non relevent features
			obj_orb.menu_mode = 0;
			instance_destroy(look_inst);
		}
		else
		//negate effects when scene os over/hasnt started
		{
			turned_precent = approach(turned_precent,0.02,0);
			if(!is_capital)
				global.camera_zoom = 1.1;
			
			with(obj_king) look_at_me = 0;
		}
	}
	
	
	break;
	#endregion
	#region kinghood
	case CUTSCENES.kinghood:
	
	with(obj_player) turned_precent = approach(turned_precent,0.04,0);
	//scene_ost = OST.turn;
	ost_index = OST.turn;
	
	var _zoom_spd = 0.001;
	
	switch(stage)
	{
		//setup the scene
		case 0:
		
		ost_index = OST.turn;
		//scene_ost = OST.turn;
		obj_speedrun.reached_ending = 1;
		global.camera_zoom = 0.8;
		obj_player.bow = 0;
		
		stage++;
		break;
		////////////// wait for the player to pick up the crown
		case 1:
		
		ost_index = OST.king;
		if(place_meeting(obj_player.x,obj_player.y,obj_crown))
		{
			stage++;
			depth = obj_player.depth-1  //???
			obj_crown.r = 100;
			obj_crown.my_x = obj_crown.x;
			
			with(obj_player)
			{
				momentum_y = -25;
				hard_grav = 0.5;
			}
		}
		
		break;
		/////////// flip the crown
		case 2:
		
		global.camera_zoom = approach(global.camera_zoom,_zoom_spd,1.3);
		ost_index = OST.king2;
		with(obj_player)
		{
			has_control = 0;
			hard_grav = 0.5;
			x = approach(x,3,obj_player_dead.x);	
		}
		
		with(obj_crown)
		{
			//move
			state = 1;
			var ydest = 535
			y = lerp(y,ydest,0.012)
			var _xx = obj_player.x;
			
			r = max(10,abs(y-ydest))
			
			my_x = approach(my_x,4,_xx);
			x = my_x+wave(-r,+r,1.4,0);
			
			r = approach(r,0.1,0);
			
			//change depth
			if(x > xprevious) depth = obj_player.depth+1
			else			  depth = obj_player.depth-1
			
			//detect ending
			if(abs(y-ydest)<2)
			{
				other.stage++;
			}
		}
		
		break;
		/////////magnet crown to player
		case 3:
		
		global.camera_zoom = approach(global.camera_zoom,_zoom_spd,1.3);
		ost_index = OST.king2;
		with(obj_player)
		{
			has_control = 0;
			grav = 0;
			vsp = 0;
			y = approach(y,2,obj_trigger.y-10);
		}
		
		with(obj_crown)
		{
			y = approach(y,3,obj_player.bbox_top);
		}
		
		//detect ending
		if(obj_crown.y == obj_player.bbox_top)
		{
			stage++;
			obj_player.is_king = 1
			instance_destroy(obj_crown);
			obj_player.momentum_y -= 10;
		}
			
		break;
		//////////////////////player stands in the center
		case 4:
		
		ost_index = OST.king2;
		obj_player.has_control = 1;
		global.camera_zoom = approach(global.camera_zoom,_zoom_spd,1.3);
		
		var is = place_meeting(obj_player.x,obj_player.y+30,obj_anvil)
		proceed += is//approach(proceed,1,120*is)
		
		if(proceed > 0)
		{
			with(obj_capital) state = CAPITAL_STATES.bow;
		}
		
		if(proceed == 300)
		{
			obj_game.list_got_endings[|ENDINGS.kinghood] = 1;
			with instance_create_depth(0,0,0,obj_credits)
			{
				end_index = ENDINGS.kinghood;
			}
			stage++;
		}
		break;
	}
	
	break;
	#endregion
	#region escape
	case CUTSCENES.escape:
	
	if(stage == 0)
	{
		audio_stop_sound(ost_escape)
		escape_sound = audio_play_sound(ost_escape,SOUND.music,1);
		stage++;
	}
	
	with(obj_player) other.escape_precent = 1 - (y/room_height);
	
	var _cur = animcurve_get(cur_escape);
	var _channel = animcurve_get_channel(_cur,2)
	
	escape_overlay_a = animcurve_channel_evaluate(_channel,escape_precent);
	
	_channel = animcurve_get_channel(_cur,0);
	global.music_volume_amp = animcurve_channel_evaluate(_channel,escape_precent);
	
	_channel = animcurve_get_channel(_cur,1);
	escape_volume = global.music_volume*animcurve_channel_evaluate(_channel,escape_precent);
	
	_channel = animcurve_get_channel(_cur,3);
	global.camera_zoom = animcurve_channel_evaluate(_channel,escape_precent);
	
	audio_sound_gain(escape_sound,escape_volume,0);
	
	break;
	
	#endregion
	#region rewards
	
	#region reward1
	case CUTSCENES.reward1:

	if(room != rm_pit_bottom)
	{
		instance_destroy();
		exit;
	}
		
	switch(stage)
	{
		case 0:
			
			//vars
			var _trigger = instance_find(obj_trigger,0);
			reward_wall = instance_place(_trigger.x,_trigger.y,obj_wall);
			mask_index = mask_pixel;
			wall_dest = reward_wall.x+64;
			
			//create unlock
			with(instance_create_depth(_trigger.x,_trigger.y,0,obj_orb_unlock))
			{
				index = REWARD_COLOR.reward1;
				creation_num = REWARD_ID.reward1;
			}
			stage++;
			
		break;
		//////////
		case 1:
			
			reward_wall.x = lerp(reward_wall.x,wall_dest,0.1);
			reward_wall.x = approach(reward_wall.x,1,wall_dest);
			if(reward_wall.x == wall_dest)
				stage++;
				
		break;
		////////////
	
	}
	
	break;
	#endregion
	#region reward2
	case CUTSCENES.reward2:
	
	if(room != rm_pit_bottom)
	{
		instance_destroy();
		exit;
	}
		
	switch(stage)
	{
		case 0:
			
			//vars
			var _trigger = instance_find(obj_trigger,0);
			reward_wall = instance_place(_trigger.x,_trigger.y,obj_wall);
			mask_index = mask_pixel;
			wall_dest = reward_wall.x+64;
			
			//create unlock
			with(instance_create_depth(_trigger.x,_trigger.y,0,obj_orb_unlock))
			{
				index = REWARD_COLOR.reward2;
				creation_num = REWARD_ID.reward2;
			}
			stage++;
			
		break;
		//////////
		case 1:
			
			reward_wall.x = lerp(reward_wall.x,wall_dest,0.1);
			reward_wall.x = approach(reward_wall.x,1,wall_dest);
			if(reward_wall.x == wall_dest)
				stage++;
				
		break;
		////////////
	
	}
	
	break;
	#endregion
	#region reward3
	case CUTSCENES.reward3:
	
	if(room != rm_pit_bottom)
	{
		instance_destroy();
		exit;
	}
		
	switch(stage)
	{
		case 0:
			
			//vars
			var _trigger = instance_find(obj_trigger,0);
			reward_wall = instance_place(_trigger.x,_trigger.y,obj_wall);
			mask_index = mask_pixel;
			wall_dest = reward_wall.x+64;
			
			//create unlock
			with(instance_create_depth(_trigger.x,_trigger.y,0,obj_orb_unlock))
			{
				index = REWARD_COLOR.reward3;
				creation_num = REWARD_ID.reward3;
			}
			stage++;
			
		break;
		//////////
		case 1:
			
			reward_wall.x = lerp(reward_wall.x,wall_dest,0.1);
			reward_wall.x = approach(reward_wall.x,1,wall_dest);
			if(reward_wall.x == wall_dest)
				stage++;
				
		break;
		////////////
	
	}
	
	break;
	#endregion
	#region reward4
	case CUTSCENES.reward4:
	
	if(room != rm_pit_bottom)
	{
		instance_destroy();
		exit;
	}
		
	switch(stage)
	{
		case 0:
			
			//vars
			var _trigger = instance_find(obj_trigger,0);
			reward_wall = instance_place(_trigger.x,_trigger.y,obj_wall);
			mask_index = mask_pixel;
			wall_dest = reward_wall.x+64;
			
			//create unlock
			with(instance_create_depth(_trigger.x,_trigger.y,0,obj_orb_unlock))
			{
				index = REWARD_COLOR.reward4;
				creation_num = REWARD_ID.reward4;
			}
			stage++;
			
		break;
		//////////
		case 1:
			
			reward_wall.x = lerp(reward_wall.x,wall_dest,0.1);
			reward_wall.x = approach(reward_wall.x,1,wall_dest);
			if(reward_wall.x == wall_dest)
				stage++;
				
		break;
		////////////
	
	}
	
	break;
	#endregion
	#region reward5
	case CUTSCENES.reward5:
	
	if(room != rm_pit_bottom)
	{
		instance_destroy();
		exit;
	}
		
	switch(stage)
	{
		case 0:
			
			//vars
			var _trigger = instance_find(obj_trigger,0);
			reward_wall = instance_place(_trigger.x,_trigger.y,obj_wall);
			mask_index = mask_pixel;
			wall_dest = reward_wall.x+64;
			
			//create unlock
			with(instance_create_depth(_trigger.x,_trigger.y,0,obj_orb_unlock))
			{
				index = REWARD_COLOR.reward5;
				creation_num = REWARD_ID.reward5;
			}
			stage++;
			
		break;
		//////////
		case 1:
			
			reward_wall.x = lerp(reward_wall.x,wall_dest,0.1);
			reward_wall.x = approach(reward_wall.x,1,wall_dest);
			if(reward_wall.x == wall_dest)
				stage++;
				
		break;
		////////////
	
	}
	
	break;
	#endregion
	
	//end rewards
	#endregion
	#region destruction
	case CUTSCENES.destruction:
	
	switch(stage)
	{
		#region wait for power plant to vanish
		case 0:
		if(obj_power_plant.scale == 0)
		{
			stage++;
			alarm[0] = 60;
		}
		else
		{
			var _sfx = sfx_power_plant_slow
			audio_sound_pitch(_sfx,audio_sound_get_pitch(_sfx)-0.03);
		}
		break;
		#endregion
		#region timeout
		case 1:
		if(alarm[0] == 0)
		{
			stage++;
		}
		break;
		#endregion
		#region lights out
		case 2:
		
		play_sfx(sfx_destruction);
		instance_create_depth(0,0,0,obj_darkness);
		obj_music.current_song = obj_music.list_ost[|OST.none];
		audio_sound_gain(ost_capital,0,0);
		global.darkness_alpha = 0.6;
		stage++;
		alarm[0] = 60*5;
		
		break;
		#endregion
		#region wait for lights and trigger
		case 3:
		
		if(alarm[0] == 0)
		{
			global.flag_destruction = 1;
		}
		
		break;
		#endregion
	}
	
	break;
	#endregion
	#region pink hub
	case CUTSCENES.pink_hub:
	
	if(instance_exists(obj_camera_border))
	with(obj_disruptor) if(index == ORB_STATES.yellow and !active)
		instance_destroy(obj_camera_border);
	
	break;
	#endregion
}
depth = DEPTH.ui_game;
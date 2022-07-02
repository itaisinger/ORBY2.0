///@description black
current_color = COLORS.black;
var s_mode = menu_mode; //used to play sfx

if(menu_mode)
{	
	//act out 
	switch(return_value)
	{
		#region create
		case "create":
		
		obj_player.draw_xs = 1.2;
		obj_player.draw_ys = 0.7;
		
		with(obj_spawn) state = SPAWN_STATES.destroy;
		var s = instance_create_depth(obj_player.x,obj_player.y,depth,obj_spawn);
		s.creation_num = list_savepoints[|0];
		ds_list_delete(list_savepoints,0);
		menu_mode = 0;
		
		with(obj_menu_text) state = TEXT_STATES.off;
		
		//save an individual save file
		with obj_saveload event_user(SAVELOAD.save_savepoint);
		//save the list to remove the used one
		save_savepoints(); 
		
		break;
		#endregion
		#region load
		case "load":
		
		transition(TRANS_STATES.load_checkpoint);
		
		break;
		#endregion
	}
	return_value = "";
	
	var om = obj_mouse;
	if(om.x < x-radius or om.x > x+radius)
	or(om.y < y-radius or om.y > y+radius)
	{
		menu_mode = 0;
	}
	
	//set some stuff
	is_anchored = 1;
	radius_dest = menu_mode_radius;
	
}
else
{
	is_anchored = 0;
	
	var can_switch = 1;
	if(instance_exists(obj_cutscene))
	if(room == rm_level_1)
		can_switch = 0;
	
	if(key_1 and can_switch)
	{
		#region transition to menu mode
		with(obj_menu_text) instance_destroy();
		menu_mode = 1;
		
		//create
		with instance_create_depth(x,y,depth-1,obj_menu_text)
		{
			font = font_message;
			depth = other.depth-1;
			parent = other;
			other.text_create = self;
			text = "create";
			scale = 0;
			return_value = "create";
		}
		
		//load
		with instance_create_depth(x,y,depth-1,obj_menu_text)
		{
			font = font_message;
			depth = other.depth-1;
			parent = other;
			other.text_load = self;
			text = "load";
			scale = 0;
			return_value = "load";
		}
		
		#endregion
	}
}

//updating the text insts is moved to step event, so it could be updated after switching color.

//sfx
if(s_mode != menu_mode)
{
	if(menu_mode) play_sfx(sfx_menu_black_on);
	else		  play_sfx(sfx_menu_black_off);
}


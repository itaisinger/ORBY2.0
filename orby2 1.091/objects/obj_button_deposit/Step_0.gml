///@description 
#region text stuff

//setup colors
var colors		   = array_create(0,0);
var outline_colors = array_create(0,0);
	
colors[SHADES.normal] = color_base;
colors[SHADES.light]  = merge_color(color_base,c_white, 0.2);
colors[SHADES.dark]   = merge_color(color_base,c_black, 0.3);
colors[SHADES.dark2]  = merge_color(color_base,c_black, 0.5);

outline_colors[SHADES.normal] = outline_base_color;
outline_colors[SHADES.light]  = merge_color(outline_base_color,c_white, 0.2);
outline_colors[SHADES.dark]   = merge_color(outline_base_color,c_black, 0.3);
outline_colors[SHADES.dark2]  = merge_color(outline_base_color,c_black, 0.5);

//"create" bbox
draw_set_font(font);
var margin = 10;
image_xscale = (string_width(text) +margin*2) * (scale+scale_add);
image_yscale = (string_height(text)+margin*2) * (scale+scale_add);

//stick to bbox
x = xstart - image_xscale/2;
y = ystart - image_yscale/2;

depth = DEPTH.text;

switch(state)
{
	case TEXT_STATES.natural:
		color = colors[SHADES.normal];
		outline_color = outline_colors[SHADES.normal];
		
		if(place_meeting(x,y,obj_orb) and !mouse_check_button(mb_left)) 
			state = TEXT_STATES.hover;
		break;
	////////////////////////////
	case TEXT_STATES.hover:
		color = colors[SHADES.dark];
		outline_color = outline_colors[SHADES.dark];
		
		if(!place_meeting(x,y,obj_orb))
			state = TEXT_STATES.natural;
		else if(mouse_check_button(mb_left))
		{
			state = TEXT_STATES.hold;
			//obj_cutscene.stage++;
			action = "deposit";
			counter = 60;
		}
	
		break;
	////////////////////////////
	case TEXT_STATES.hold:
		color = colors[SHADES.dark2];
		outline_color = outline_colors[SHADES.dark2];
		
		break;
	//////////////////////////////
	case TEXT_STATES.off:
		color = colors[SHADES.dark];
		outline_color = outline_colors[SHADES.light];
		//to get out from this state an outside object must set the state.
		break;
}
#endregion
#region deposit

if(action == "deposit" and alarm[0] == 1)
{
	if(ds_list_size(obj_orb.list_savepoints))
	{
		randomize();
		ds_list_delete(obj_orb.list_savepoints,0);
		with instance_create_depth(obj_orb.x,obj_orb.y,depth,obj_flying_energy)
		{
			xdest = 100;
			ydest = -200;
			image_xscale = 1.5;
			image_yscale = 1.5;
			direction = random_range(60,180);
		}
		obj_game.energy_deposited++;
		
		
		//msg
		if(obj_orb.message_full != obj_orb_message.messages_strs[MESSAGES.end_obedience])
			obj_orb.message_full = obj_orb_message.messages_strs[MESSAGES.deposit];
	}
	else
	{
		state = TEXT_STATES.natural;
		action = "";
	}
}



#endregion
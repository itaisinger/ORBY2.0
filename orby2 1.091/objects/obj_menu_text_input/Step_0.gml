///@description 

//fix text
text = base_text + " " + chr(obj_input.list_binds[|input_index]);

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
image_xscale = string_width(text)  * (scale+scale_add);
image_yscale = string_height(text) * (scale+scale_add);

//destruct if out of menu
if(!instance_exists(parent))
	instance_destroy();

//stick to bbox
x = xstart - image_xscale/2;
y = ystart - image_yscale/2;


switch(state)
{
	case TEXT_STATES.natural:
		color = colors[SHADES.normal];
		outline_color = outline_colors[SHADES.normal];
		
		if(place_meeting(x,y,obj_mouse) and !mouse_check_button(mb_left)) 
			state = TEXT_STATES.hover;
		break;
	////////////////////////////
	case TEXT_STATES.hover:
		color = colors[SHADES.dark];
		outline_color = outline_colors[SHADES.dark];
		
		if(!place_meeting(x,y,obj_mouse))
			state = TEXT_STATES.natural;
		else if(mouse_check_button(mb_left))
			state = TEXT_STATES.hold;
			
		break;
	////////////////////////////
	case TEXT_STATES.hold:
		color = colors[SHADES.dark2];
		outline_color = outline_colors[SHADES.dark2];
		
		if(!mouse_check_button(mb_left))
		{
			if(place_meeting(x,y,obj_mouse))
			{
				state = TEXT_STATES.hover;
				parent.return_value = return_value; //activate action
			}
			else state = TEXT_STATES.natural;
		}
		break;
	//////////////////////////////
	case TEXT_STATES.off:
		color = colors[SHADES.dark];
		outline_color = outline_colors[SHADES.light];
		//to get out from this state an outside object must set the state.
		break;
}
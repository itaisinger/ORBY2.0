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
			action = "open";
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
#region walls open/close

var trigger_wall_l = noone;
var trigger_wall_r = noone;
		
for(var i=0; i < instance_number(obj_trigger); i++)
{
	var inst = instance_find(obj_trigger,i);
		
	switch(inst.index)
	{
		case "wall open left":  trigger_wall_l = inst; break;
		case "wall open right": trigger_wall_r = inst; break;
	}
}

if(wall_l == noone) wall_l = instance_place(trigger_wall_l.x,trigger_wall_l.y,obj_wall);
if(wall_r == noone) wall_r = instance_place(trigger_wall_r.x,trigger_wall_r.y,obj_wall);
		
switch(action)
{
	case "open":
	wall_r.x = approach(wall_r.x,2,wall_r.xstart+32);
	wall_l.x = approach(wall_l.x,2,wall_l.xstart-32);
	counter--;
	if(counter <= 0) action = "close";
	break;
	////////////////
	case "close":
	wall_r.x = approach(wall_r.x,2,wall_r.xstart);
	wall_l.x = approach(wall_l.x,2,wall_l.xstart);
	break;
	////////////////
}

#endregion
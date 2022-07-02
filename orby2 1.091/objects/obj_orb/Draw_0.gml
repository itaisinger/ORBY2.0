if(room == rm_pit_trailer) exit;
#region draw self

var o_color = draw_colors[current_color]; //used to draw messages

switch(draw_mode)
{
	case DRAW_MODES.natural:
	
	draw_set_alpha(image_alpha);
	
	draw_set_color(draw_colors[current_color]);
	if(disabled) draw_set_color(draw_colors[COLORS.gray]);
	draw_set_color(merge_color(draw_get_color(),draw_colors[flash_color],flash_a));
	
	var r = clamp(radius*draw_s,1,100);
	
	var xoff = 0;
	var yoff = 0;
	if(error_frames > 0)
	{
		error_frames--;
		xoff = random_range(-2,2);
		yoff = random_range(-2,2);
	}

	if(!draw_cube) draw_circle(x+xoff,y+yoff,r,0);
	else		   draw_rectangle(x+xoff-r,y+yoff-r, x+xoff+r,y+yoff+r, 0);
	
	o_color = draw_get_color(); //used to draw message
	draw_reset();
	
	break;
	//////////////
	case DRAW_MODES.rec:
	
	draw_set_alpha(image_alpha)
	draw_set_color(draw_colors[current_color]);
	o_color = draw_get_color(); //used to draw message
	draw_set_color(merge_color(draw_get_color(),draw_colors[flash_color],flash_a));
		
	//draw myself
	draw_rectangle(x-rec_w/2,y-rec_h/2, x+rec_w/2,y+rec_h/2,0);
	
	//draw_set_color(draw_colors[current_color]);
	//o_color = draw_get_color(); //used to draw message
	//draw_rectangle(x-rec_w/2,y-rec_h/2, x+rec_w/2,y+rec_h/2,0);
	draw_reset();
	
	break;

}
#endregion
#region draw menu

if(menu_active and state != ORB_STATES.menu)
{

var num = list_sum(unlocked_colors);
var r = 6;
var s_scale = 0.3;
switch(draw_mode)
{
	case DRAW_MODES.natural: startx = x + radius  + 5; break;
	case DRAW_MODES.rec:	 startx = x + max(radius,rec_w)/2 + 5; break;
}
var starty = y - ((r-1)*num + r*(1+s_scale))/2;
if(message_current != "")
	starty = y - radius;
var yy = 0;
var selected = 0;

var xoff = 0;
var yoff = 0;
if(error_frames_menu > 0)
{
	error_frames_menu--;
	xoff = random_range(-1,1);
	yoff = random_range(-1,1);
}

draw_set_font(font_orb_menu);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//draw black cuz its not ordered
var i = ORB_STATES.black;
if(unlocked_colors[|i])
{
	draw_set_color(draw_colors[i]);
	
	if(i == state) selected = 1;
	else selected = 0;
	
	var l = r*(1 + selected*s_scale);
	
	draw_rectangle(startx+xoff,starty+yoff+yy, startx+xoff+l,starty+yoff+l+yy, 0);
	
	yy += l + 3;
}

//draw the rest 
light_menu_coords = []; //reset yellow menu pos
for(var i=0; i < ds_list_size(unlocked_colors)-1; i++)
{
	if(unlocked_colors[|i])
	{
		draw_set_color(draw_colors[i]);
	
		if(i == state) selected = 1;
		else selected = 0;
	
		var l = r*(1 + selected*s_scale);
	
		draw_rectangle(startx+xoff,starty+yoff+yy, startx+xoff+l,starty+yoff+l+yy, 0);
		
		if(i == ORB_STATES.yellow)
		{
			//light_menu_coords = [startx+xoff+l/2,starty+yoff+l/2+yy];
			light_menu_coords = [startx+xoff,starty+yoff+yy, startx+xoff+l,starty+yoff+l+yy];
		}
		
		yy += l + 3;
	}
}

}

#endregion
#region draw platform uses

if(state = COLORS.purple)
{

var num = platform_max
var r = platform_display_base;
var s_scale = 0.3;
var startx = 0;

//scale down 
if(array_length(platform_display_sizes) < platform_max)
	platform_display_sizes[platform_max] = 0;
	
for(var i=0; i < platform_max; i++)
	platform_display_sizes[i] = approach(platform_display_sizes[i], 0.35, r);


switch(draw_mode)
{
	case DRAW_MODES.natural: startx = x - radius  - 5 - r/2; break;
	case DRAW_MODES.rec:	 startx = x - max(rec_w,radius)/2 - 5 - r/2; break;
}
var starty = y - r*num/2;
var yy = 0;

//draw unused uses
for(var i=0; i < platform_current; i++)
{
	draw_set_color(draw_colors[COLORS.purple]);
	
	r = platform_display_sizes[i];
	var w = r*1.4;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}
//draw used uses
draw_set_alpha(0.4);
for(var i=platform_current; i < platform_max; i++)
{
	draw_set_color(draw_colors[COLORS.gray]);
	
	var w = r*1.2;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}
draw_set_alpha(1);
}
#endregion
#region draw spawn uses

if(state = COLORS.black)
{

var num = ds_list_size(list_savepoints);
var r = platform_display_base;
var s_scale = 0.3;
var startx = 0;

//lengthen the array if a new use is added
if(num > array_length(save_display_sizes))
	save_display_sizes[num] = 0;

//scale down 
for(var i=0; i < num; i++)
	save_display_sizes[i] = approach(save_display_sizes[i], 0.35, r);

switch(draw_mode)
{
	case DRAW_MODES.natural: startx = x - radius  - 5 - r/2; break;
	case DRAW_MODES.rec:	 startx = x - max(rec_w,radius)/2 - 5 - r/2; break;
}
var starty = y - r*num/2;
var yy = 0;

//draw unused uses
for(var i=0; i < num; i++)
{
	draw_set_color(draw_colors[COLORS.black]);
	
	r = save_display_sizes[i];
	var w = r*1.2;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}

}
#endregion
#region draw pink uses

if(state = ORB_STATES.pink)
{

var num = pink_max
var r = platform_display_base;
var s_scale = 0.3;
var startx = 0;

startx = x - radius - 5 - r/2;
var starty = y - r*num/2;
var yy = 0;

//draw unused uses
for(var i=0; i < pink_remain; i++)
{
	draw_set_color(draw_colors[COLORS.pink]);
	
	r = platform_display_base;
	var w = r*1.4;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}
//draw used uses
draw_set_alpha(0.4);
for(var i=pink_remain; i < pink_max; i++)
{
	draw_set_color(draw_colors[COLORS.gray]);
	
	var w = r*1.2;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}
draw_set_alpha(1);

}

#endregion
#region draw light uses

if(state = ORB_STATES.yellow)
{

var num = light_max
var r = platform_display_base;
var s_scale = 0.3;
var startx = 0;

startx = x - radius - 5 - r/2;
var starty = y - r*num/2;
var yy = 0;

//draw unused uses
for(var i=0; i < light_remain; i++)
{
	draw_set_color(draw_colors[COLORS.yellow]);
	
	r = platform_display_base;
	var w = r*1.4;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}
//draw used uses
draw_set_alpha(0.4);
for(var i=light_remain; i < light_max; i++)
{
	draw_set_color(draw_colors[COLORS.gray]);
	
	var w = r*1.2;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}
draw_set_alpha(1);

}

#endregion
#region draw green uses

if(state = ORB_STATES.green)
{

var num = green_max
var r = platform_display_base;
var s_scale = 0.3;
var startx = 0;

startx = x - radius - 5 - r/2;
var starty = y - r*num/2;
var yy = 0;

//draw unused uses
for(var i=0; i < green_remain; i++)
{
	draw_set_color(draw_colors[COLORS.green]);
	
	r = platform_display_base;
	var w = r*1.4;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}
//draw used uses
draw_set_alpha(0.4);
for(var i=green_remain; i < green_max; i++)
{
	draw_set_color(draw_colors[COLORS.gray]);
	
	var w = r*1.2;
	draw_rectangle(startx+w/2,starty+yy, startx-w/2,starty+r+yy, 0);
	yy += r + 3;
}
draw_set_alpha(1);

}

#endregion
#region draw_message

if(!instance_exists(obj_pause))
{	
	draw_set_all(c_white,font_ui,1,fa_center,fa_middle);
	var m_ydest = -max(radius,rec_h/2) - 5 - string_height(message_full)/2;
	
	//dont overlapp with player
	if(place_meeting(x,y+m_ydest,obj_player) and state_action != 0)
	{
		m_ydest = max(radius,rec_h/2) + 5 + string_height(message_full)/2;
	}

	//move y to ydest
	message_yoff = lerp(message_yoff,m_ydest,0.1);
	
	draw_set_color(get_colors_background(current_color));
	var message_str = string_part(message_current,5,string_length(message_current));
	draw_text_outline(x,y+message_yoff,message_str,2,o_color);
}
#endregion

//draw_set_color(c_black)
//draw_circle(x,y,3,0);
//draw_reset();
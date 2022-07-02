#region choose color index
if(list_sum(unlocked_colors))
{
	while(!unlocked_colors[|color_index])
	{
		color_index++;
		if(color_index >= ds_list_size(unlocked_colors)) color_index = 0;
	}
	
	if(mouse_wheel_down())
	{
		color_index--;
	
		while(!unlocked_colors[|color_index])
		{
			color_index--;
			if(color_index < 0) color_index = ds_list_size(unlocked_colors);
		}
	}

	if(mouse_wheel_up())
	{
		color_index++;
	
		while(!unlocked_colors[|color_index])
		{
			color_index++;
			if(color_index >= ds_list_size(unlocked_colors)) color_index = 0;
		}
	}
}
#endregion
#region choose corresponding color
switch(color_index)
{
	case ORB_STATES.purple: color = COLORS.purple; break;
	case ORB_STATES.orange: color = COLORS.orange; break;
	case ORB_STATES.blue:   color = COLORS.blue;   break;
	case ORB_STATES.yellow: color = COLORS.yellow; break;
	case ORB_STATES.black:  color = COLORS.black;  break;
}

#endregion
#region movement

xdest = mouse_x;
ydest = mouse_y;
	
var spd = point_distance(x,y, xdest,ydest)/4;
var dir  = point_direction(x,y, mouse_x, mouse_y);
var xspd = abs(lengthdir_x(spd, dir))
var yspd = abs(lengthdir_y(spd, dir))
	
xspd = clamp(xspd,1,50);
yspd = clamp(yspd,1,50);
	
x = approach(x,xspd,xdest)
y = approach(y,yspd,ydest)

#endregion


if(instance_exists(obj_pause)) exit;

//huge ass workaround
if(room == rm_pink_run and instance_number(obj_green) == 1) 
{
	pink_run();
	exit;
}
#region states

if(state = 1) is_anchored = 1;

#endregion
#region setup vars
var cam = view_camera[target_view];

//Get target view position and size. size is halved so the view will focus around its center
var vpos_w = camera_get_view_width(cam) * 0.5;
var vpos_h = camera_get_view_height(cam) * 0.5;

#endregion
#region zoom

var _zoom_prev = zoom_level;
zoom_level = global.camera_zoom;

var _zoom_changed = zoom_level != _zoom_prev;

if(!instance_exists(obj_cutscene))
with(obj_player)
{
	var border = instance_place(x,y,obj_camera_border)
	if(border != noone)
	if(border.zoom != -1)
		other.zoom_level = border.zoom;
}

//Get current size
view_w = camera_get_view_width(cam);
view_h = camera_get_view_height(cam);

//Set the rate of interpolation
var rate = 0.03;
if(instance_exists(obj_transition))
if(obj_transition.state == TRANS_STATES.intro)
	rate *= 10;

//Get new sizes by lerping current and target zoomed size
//var new_w = round(lerp(view_w, zoom_level * default_zoom_width,  rate));
//var new_h = round(lerp(view_h, zoom_level * default_zoom_height, rate));
var new_w = lerp(view_w, zoom_level * default_zoom_width,  rate);
var new_h = lerp(view_h, zoom_level * default_zoom_height, rate);

//Apply the new size
camera_set_view_size(cam, new_w, new_h);

//Get the shift necessary to re-align the view.
x = x - (new_w - view_w) * 0.5;
y = y - (new_h - view_h) * 0.5;

#endregion
#region move

//reset borders
xmin = 0;
xmax = room_width;
ymin = 0;
ymax = room_height;

//determine if there are relevent borders
with(obj_camera_border)
{
	if(place_meeting(x,y,obj_player))
		event_user(0);
		
	if(place_meeting(x,y,obj_credits))
		event_user(0);
		
}

//find the destenation
var follow = instance_find(obj_follow,0);
if(follow == noone)
	follow = instance_find(obj_player,0);
else if(follow.follow_active != 1) follow = instance_find(obj_player,0);

if(follow != noone)
{
	look_x = follow.x;
	look_y = follow.y;
}

//The interpolation rate
var rate = 0.1*(!is_anchored);

//move fast on level start
if(obj_transition.state == TRANS_STATES.intro)
	rate *= 10;

//move slow when using purple orb
var _o = obj_orb;
if(instance_exists(obj_player) and instance_exists(_o) and !instance_exists(obj_credits))
if(!obj_player.ground and (_o.state == ORB_STATES.purple or _o.state == ORB_STATES.pink)
and !_o.disabled and obj_player.y < y+view_h-100 and obj_player.killer == noone)
	rate *= 0.06;


//add shakevar shakex = 0, shakey = 0;
var shake = 0;
if(global.camera_shake>0)
{
	global.camera_shake = approach(global.camera_shake,0.05,0);
	
	shake = global.camera_shake * 40;
	shakex = random_range(-shake,shake);
	shakey = random_range(-shake,shake);
}

var _xdest = look_x - vpos_w;
var _ydest = look_y - vpos_h;

//Interpolate the view position to the new, relative position.
x = lerp(x, clamp(_xdest,xmin,xmax-vpos_w*2) + shakex, rate);
y = lerp(y, clamp(_ydest,ymin,ymax-vpos_h*2) + shakey, rate);

//currently, screen shake overrides camera border.

//update camera moved for other objects
camera_moved = x != xprevious or y != yprevious or _zoom_changed;

//stay in the room borders
x = clamp(floor(x), 0, room_width  - camera_get_view_width(cam));
y = clamp(floor(y), 0, room_height - camera_get_view_height(cam));

//Update the view position
camera_set_view_pos(cam,x, y);

//set camera angle to apply camera shake
camera_set_view_angle(cam,random_range(-shake/35,shake/35))

#endregion
global.camera_zoom = 1;
global.camera_shake = 0;

state = 0;
enum CAMERA_STATES{
	natural,
	anchor,
}

xmin = -1;
xmax = -1;
ymin = -1;
ymax = -1;
shakex = 0;
shakey = 0;
camera_moved = 0;


function pink_run(){


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

//Get current size
view_w = camera_get_view_width(cam);
view_h = camera_get_view_height(cam);

//Set the rate of interpolation
var rate = 0.03;
if(instance_exists(obj_transition))
if(obj_transition.state == TRANS_STATES.intro)
	rate *= 10;

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
}

//find the destenation
var follow = instance_find(obj_green,0);

var _dest = follow.x-vpos_h*0.3
if(_dest > x)
	x = approach(x,follow.spd,_dest);

look_y = room_height - 64 - vpos_h;

//var _xdest = look_x - vpos_w;
var _ydest = look_y - vpos_h;

//Interpolate the view position to the new, relative position.
//x = lerp(x, clamp(_xdest,xmin,xmax-vpos_w*2) + shakex, rate);
y = lerp(y, clamp(_ydest,ymin,ymax-vpos_h*2) + shakey, rate);

//update camera moved for other objects
camera_moved = x != xprevious or y != yprevious or _zoom_changed;

//stay in the room borders
x = clamp(floor(x), 0, room_width  - camera_get_view_width(cam));
y = clamp(floor(y), 0, room_height - camera_get_view_height(cam));

//Update the view position
camera_set_view_pos(cam,x, y);

#endregion
}
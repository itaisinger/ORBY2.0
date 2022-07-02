///@description 

#region set dest

xdest = obj_mouse_npc.x;
ydest = obj_mouse_npc.y;

#endregion
#region move

if(!placed)
{

var spd = point_distance(x,y, xdest,ydest)/5;
var dir  = point_direction(x,y, xdest, ydest);
var xspd = lengthdir_x(spd, dir)
var yspd = lengthdir_y(spd, dir)

if(abs(xspd)<1) xspd = 0//sign(xspd);
if(abs(yspd)<1) yspd = 0//sign(yspd);

//collision
if(place_meeting(x+xspd,y,obj_orb_solid))
{
	while(!place_meeting(x+sign(xspd),y,obj_orb_solid))
		x += sign(xspd);
	xspd = 0;
}

if(place_meeting(x,y+yspd,obj_orb_solid))
{
	while(!place_meeting(x,y+sign(yspd),obj_orb_solid))
		y += sign(yspd);
	yspd = 0;
}

x += xspd;
y += yspd;

}


#endregion
#region wall inst

if(placed)
{
	if(!instance_exists(wall_inst))
		with(instance_create_depth(x-w/2,y-h/2,depth+1,obj_wall))
		{
			other.wall_inst = self;
			
			//y should stay the same
			sprite_index = mask_pixel;
			image_xscale = other.w;
			image_yscale = other.h;
		}
	
	wall_inst.sprite_index = mask_pixel;
	wall_inst.mask_index = mask_pixel;
}
else instance_destroy(wall_inst);

#endregion
#region logic
if(instance_exists(obj_miner))
{
	if(obj_miner.y > 726)
	{
		uses = uses_max;
	}
	
	if(y > obj_miner.y and alarm[0] < 1 and !placed)
	{
		alarm[0] = 20;
		if(uses > 0)
		{
			placed = 1;
			uses--;
		}
		else error_frames = 25;
	}
}

error_frames = max(error_frames-1,0);


	
#endregion

instance_destroy(obj_orb_miner);
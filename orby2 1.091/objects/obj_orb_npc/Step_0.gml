///@description 


#region set dest

if(point_distance(x,y,xdest,ydest)<5 or xdest == 0 or walk_cd == 0 or (x==xprevious and y==yprevious))
{
	if(walk_cd>0) walk_cd--;
	else
	{
		walk_cd  = irandom(60);
		walk_spd = irandom_range(40,100);
		var ob = instance_find(obj_orb_range,0);
		xdest  = random_range(ob.bbox_left,ob.bbox_right)
		ydest  = random_range(ob.bbox_top ,ob.bbox_bottom)
		
		if(walk_spd%5 == 0) 
			my_color = colors[random(array_length(colors))]
	}
}


#endregion
#region move

if(walk_spd%4 == 0)
{
	walk_cd -= 0.2;
	xdest = obj_orb.x;
	ydest = obj_orb.y;
}

var spd = point_distance(x,y, xdest,ydest)/walk_spd;
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

image_xscale = 2*r;
image_yscale = 2*r;

#endregion
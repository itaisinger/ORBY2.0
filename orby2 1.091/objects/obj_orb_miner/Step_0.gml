
if(instance_exists(parent))
{
	parentx = parent.x;
	parenty = parent.y;
}

xdest = parentx + xoff;
ydest = parenty + yoff;

var spd = point_distance(x,y, xdest,ydest)/10;
var dir  = point_direction(x,y, xdest, ydest);
var xspd = lengthdir_x(spd, dir)
var yspd = lengthdir_y(spd, dir)

if(abs(xspd)<1) xspd = 0;
if(abs(yspd)<1) yspd = 0;

x += xspd;
y += yspd;

depth = DEPTH.orb_npc;
///@description 
if(instance_exists(obj_pause)) depth = DEPTH.darkness_pause;
else						   depth = DEPTH.darkness;

points = []; //each entry is an array of 3 vars: [x,y,r]

//orb
var off = 32;
if(obj_orb.state == ORB_STATES.yellow)
	points[0] = [obj_orb.x-off,obj_orb.y-off,200];

//lamps
var _inst = noone;
for(var i=0; i < instance_number(obj_lamp); i++)
{
	_inst = instance_find(obj_lamp,i);
	points[array_length(points)] = [_inst.x-16,_inst.y-16,_inst.radius];
}

//assign points to the grid
for(var i=0; i < array_length(points); i++)
{
	points[i][0] = floor(points[i][0])//32);
	points[i][1] = floor(points[i][1])//32);
	points[i][2] = points[i][2]//32;
}
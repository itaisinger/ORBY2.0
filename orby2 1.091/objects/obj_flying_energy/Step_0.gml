///@description 
var dir_dest = point_direction(x,y,xdest,ydest)
if(angle_difference(direction,dir_dest)<30)
	speed += 0.1;
else speed = lerp(speed,0,0.05);

speed = min(speed,20);


direction = approach(direction,2,dir_dest);

//if(!going_to_center and y<0)
//	instance_destroy();

if(distance_to_point(xdest,ydest) <= speed)
	instance_destroy();
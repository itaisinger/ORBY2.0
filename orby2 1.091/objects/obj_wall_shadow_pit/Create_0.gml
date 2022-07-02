my_wall = instance_place(x,y,obj_solid);
if(my_wall == noone)
	my_wall = instance_place(x,y,obj_wall_fake);
depth = DEPTH.wall+1;
bottom = 1;
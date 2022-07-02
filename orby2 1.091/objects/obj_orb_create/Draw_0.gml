var o = noone
if(instance_exists(obj_player)) o = obj_player;
else if(instance_exists(obj_spawner)) o = obj_spawner;

	dir = approach(dir, 0.15, sign(o.x-x));
image_xscale = dir*scale;
image_yscale = scale;
draw_self();

if(r>0)//state == ORB_CREATE_STATES.create)
{
	draw_set_color(c_black);
	draw_primitive_begin(pr_trianglestrip)
	
	draw_vertex(x-r-random(min(r,spd)),y-r-random(min(r,spd)));
	draw_vertex(x+r+random(min(r,spd)),y-r-random(min(r,spd)));
	draw_vertex(x+r+random(min(r,spd)),y+r+random(min(r,spd)));
	draw_vertex(x-r-random(min(r,spd)),y+r+random(min(r,spd)));
	
	draw_vertex(x-r-random(min(r,spd)),y-r-random(min(r,spd)));
	draw_vertex(x+r+random(min(r,spd)),y-r-random(min(r,spd)));
	
	draw_primitive_end();
	
	draw_rectangle(x-r/2,y-r/2, x+r/2,y+r/2,0);
}

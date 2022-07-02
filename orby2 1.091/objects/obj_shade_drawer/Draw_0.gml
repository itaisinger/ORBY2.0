if(!instance_exists(obj_wall_shadow_pit) and !instance_exists(obj_wall_shadow))
{
	exit;
}

cx = camera_get_view_x(view_camera[0]);
cy = camera_get_view_y(view_camera[0]);
cw = camera_get_view_width(view_camera[0]);
ch = camera_get_view_height(view_camera[0]);

if(!surface_exists(sur_shade))
	sur_shade = surface_create(cw,ch);
surface_set_target(sur_shade);

draw_clear_alpha(c_black,0);

#region purple

with(obj_wall_shadow)
{
	#region setup 

	if(my_wall != -1)
	//used to temp move the wall so it would draw at the relative position on the surface
	{
		my_wall.x -= other.cx;
		my_wall.y -= other.cy;
		x -= other.cx;
		y -= other.cy;
	}
	
	//vars
	var shade = 0;
	draw_set_color(make_color_rgb(shade,shade,shade));
	var w = 64;
	var wall_y = y;
	if(my_wall != -1) wall_y = my_wall.y;
	var bottom_xstart = x - ((room_height-other.cy)-wall_y+64);//my_wall.sprite_height);
	
	#endregion
	
	draw_primitive_begin(pr_trianglestrip)
	
	if(my_wall == -1)
	{
		draw_vertex(x,y);	    //A
		draw_vertex(x+66,y+64); //C
		draw_vertex(bottom_xstart,room_height-other.cy);	   //E
		draw_vertex(bottom_xstart+w*2+2,room_height-other.cy); //D
	}
	else if(bottom)
	{
		if(my_wall.state != WALL_STATES.breaking3)
		{
			//draw normal shadow	
			draw_vertex(my_wall.bbox_left,my_wall.bbox_top);	   //A
			draw_vertex(my_wall.bbox_right+2,my_wall.bbox_bottom); //C
			draw_vertex(bottom_xstart,room_height-other.cy);	   //E
			draw_vertex(bottom_xstart+w*2+2,room_height-other.cy); //D
		}
		else
		{
			//draw slices single shadow
			if(instance_exists(my_wall.effect_wave))
				w = max(0, 64 - max(0,4*(floor(my_wall.effect_wave.image_index)-16)));
			else w = 0;
			
			draw_vertex(my_wall.x,my_wall.y);					   //A
			draw_vertex(my_wall.x+64+2,my_wall.y+w);			   //C
			draw_vertex(bottom_xstart,room_height-other.cy);	   //E
			draw_vertex(bottom_xstart+w*2+2,room_height-other.cy); //D
		}
	}
	else
	{
		//draw stacked shadow
		draw_vertex(my_wall.bbox_left,my_wall.bbox_top);      //A
		draw_vertex(my_wall.bbox_left,my_wall.bbox_bottom+1); //B
		draw_vertex(bottom_xstart,room_height-other.cy);	  //E
		draw_vertex(bottom_xstart+w,room_height-other.cy);	  //F	
	}

	//return to normal
	draw_primitive_end();
	if(my_wall != -1)
	{
		my_wall.x += other.cx;
		my_wall.y += other.cy;
		x += other.cx;
		y += other.cy;
	}
	

}

#endregion
#region pit

h = 256*global.shadow_h;
	
with(obj_wall_shadow_pit)
{
	var c_top	 = other.cy
	var c_bottom = c_top + other.ch
	
	if(my_wall.bbox_bottom < c_bottom and my_wall.y+other.h > c_top)
		draw_sprite_stretched(spr_shadow_vertical,0,my_wall.x-other.cx,my_wall.y-other.cy,my_wall.sprite_width,other.h);
}

#endregion
surface_reset_target();

draw_set_alpha(0.1);
draw_surface(sur_shade,cx,cy);
//surface_free(sur_shade)
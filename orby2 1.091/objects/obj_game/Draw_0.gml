///@description set wall color shader

//if(obj_camera.is_anchored == 1)
//{

//var xx = obj_camera.x;
//var yy = obj_camera.y;
//var cw = camera_get_view_width(view_camera[0]);
//var ch = camera_get_view_height(view_camera[0]);

//if(instance_exists(obj_orb))
//{
//	var cols = get_colors();
//	draw_set_color(cols[obj_orb.current_color]);
//}
//else draw_set_color(c_black);
//var w = 14;

//draw_line_width(xx,yy, xx+cw,yy, w);
//draw_line_width(xx,yy, xx,yy+ch, w);
//draw_line_width(xx+cw,yy, xx+cw,yy+ch, w);
//draw_line_width(xx,yy+ch, xx+cw,yy+ch, w);

//}

//draw_set_color(c_black);

shader_set_uniform_f_array(base_color,wall_colors[0]);
shader_set_uniform_f_array(my_color,global.wall_color_arr);
///@description 

var wall_color_arr = global.wall_color_arr;

shader_set(sh_distruptor);

shader_set_uniform_f_array(uni_my_color,my_color_arr)
shader_set_uniform_f_array(uni_base_color,base_color_arr);
shader_set_uniform_f_array(uni_base_wall_col,base_wall_color_arr);
shader_set_uniform_f_array(uni_wall_col,wall_color_arr);

draw_self();
shader_reset();

draw_sprite_ext(spr_disruptor_button,0,x+32,y,1+3*(1-button_a),1,0,c_white,button_a);

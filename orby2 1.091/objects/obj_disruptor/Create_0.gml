///@description 

//the orb wouldnt be able to use the color of my indexs
//index = ORB_STATES.purple;

image_index = irandom(image_number);

is_made = 0;
active = 1;
colors = get_colors();
base_color_arr = [50/255,100/255,150/255];
my_color_arr = -1;
base_wall_color_arr = [112/255,112/255,112/255];
uni_my_color		= shader_get_uniform(sh_distruptor,"my_color");
uni_base_color		= shader_get_uniform(sh_distruptor,"base_color");
uni_base_wall_col	= shader_get_uniform(sh_distruptor,"base_wall_color");
uni_wall_col		= shader_get_uniform(sh_distruptor,"wall_color");
button_a = 1;
creation_num = -1;	//the creation num is a string of the room + my index

//called from obj_game after the list is reset
function add_index(){
	ds_list_add(global.disruptors,index);
}

depth = DEPTH.wall - 6;

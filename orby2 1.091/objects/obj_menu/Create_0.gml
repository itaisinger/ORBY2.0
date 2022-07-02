
//setup vars
if(instance_number(object_index)>1)
	instance_destroy();
	
x = camera_get_view_width(view_current)/2;
var h = display_get_height();
var w = display_get_width();

got_endings = ds_list_create(); //list to display what endings are achived
text_scale = 1.4;
alarm[0] = 60; //detruction miners

#region texts

var o_col = get_colors(COLORS.black);
depth = DEPTH.ui_base;
return_value = -1 //this value indicates what action to perform. returned from the text objs.
return_value_next = -1;
ydest = h/2;
bottom_pos = h*1.5;
y = bottom_pos;

//create pause menu
text_insts = ds_list_create();
end_insts  = ds_list_create();

//load
with(instance_create_layer(x,h*2,layer,obj_menu_text))
{
	ds_list_add(other.text_insts,self);
	parent = other;
	text = "load game";
	return_value = "load";
	
	if(!file_exists(global.savefile))
		state = TEXT_STATES.off;
}

//new
with(instance_create_layer(x,h*2,layer,obj_menu_text))
{
	ds_list_add(other.text_insts,self);
	parent = other;
	text = "new game";
	return_value = "new";
}

//options
with(instance_create_layer(x,h*2,layer,obj_menu_text))
{
	ds_list_add(other.text_insts,self);
	parent = other;
	text = "options";
	return_value = "options";
}

//quit
with(instance_create_layer(x,h*2,layer,obj_menu_text))
{
	ds_list_add(other.text_insts,self);
	parent = other;
	text = "quit";
	return_value = "quit";	
}

//title
with(instance_create_layer(x,h/2-200,layer,obj_text))
{
	other.title_inst = self;
	text = "ORBY 2.0";
	scale = 3;
	color = c_white;
	outline_color = o_col;
	outline_width = 5;
	outline_double = 0; //1
}

#endregion
#region load

//load savefile
if(file_exists(global.savefile))
{
	var _wrapper = load_JSON_from_file(global.savefile);
	var _list = _wrapper[? "ROOT"];
	
	for(var i=0; i < ds_list_size(_list); i++;)
	{
		var _map = _list[|i];
		var _obj = _map[? "obj"];
		
		if(_obj == "obj_orb")
			unlocked_colors =	ds_list_deep_clone(_map[? "unlocks_colors"]);
		if(_obj == "obj_game")
		{
			ds_list_destroy(got_endings);
			got_endings =		ds_list_deep_clone(_map[? "endings"]);
		}
		if(_obj == "obj_speedrun")
		{
			if(!instance_exists(obj_speedrun)) instance_create_depth(0,0,0,obj_speedrun);
			
			with(obj_speedrun)
			{
				ds_list_destroy(list_end_times);
				list_end_times = ds_list_deep_clone(_map[? "end times"]);
			}
		}
	}
	ds_map_destroy(_wrapper);
}

//load runtimes
if(file_exists(RUNTIMES))
{
	var _map = load_JSON_from_file(RUNTIMES);
	if(variable_global_exists("map_run_times"))
		ds_map_destroy(global.map_run_times);
	global.map_run_times = ds_map_deep_clone(_map);
	log("runtimes file loaded");
}
else
{
	log("runtimes file not found");
	global.map_run_times = ds_map_create();
}


#endregion
instance_create_layer(x,y,layer,obj_menu_orb)
#region extras

//build
with instance_create_depth(h-50,20,depth,obj_text)
{
	other.build_inst = self;
	text = "build " + string(global.version);
	
	scale = 0.8;
	color = c_black;
	halign = fa_left;
	valign = fa_bottom;
}


//endings
var yy = h/2-200;
var th = string_height("endings")*0.7+5;
end_strings = ["endings got:","escape","turnover","kinghood","obedience","destruction"];

//0,endings:
with(instance_create_depth(w+200,yy,layer,obj_text))
{
	ds_list_add(other.end_insts,self);
	text = "endings got:";
	scale = 1;
	halign = fa_left;
	color = c_white;
	outline_color = o_col;
	outline_width = 2;
}
yy += th;

//1,escape
with(instance_create_depth(w+200,yy,depth,obj_text))
{
	ds_list_add(other.end_insts,self);
	text = "escape";
	scale = 1;
	halign = fa_left;
	color = c_white;
	outline_color = o_col;
	outline_width = 2;
}
yy += th;

//2,turnover
with(instance_create_depth(w+200,yy,layer,obj_text))
{
	ds_list_add(other.end_insts,self);
	text = "turnover";
	scale = 1;
	halign = fa_left;
	color = c_white;
	outline_color = o_col;
	outline_width = 2;
}
yy += th;

//3,kinghood
with(instance_create_depth(w+200,yy,layer,obj_text))
{
	ds_list_add(other.end_insts,self);
	text = "kinghood";
	scale = 1;
	halign = fa_left;
	color = c_white;
	outline_color = o_col;
	outline_width = 2;
}
yy += th;

//4,obedience
with(instance_create_depth(w+200,yy,layer,obj_text))
{
	ds_list_add(other.end_insts,self);
	text = "obedience";
	scale = 1;
	halign = fa_left;
	color = c_white;
	outline_color = o_col;
	outline_width = 2;
}
yy += th;

//5,destruction
with(instance_create_depth(w+200,yy,layer,obj_text))
{
	ds_list_add(other.end_insts,self);
	text = "destruction";
	scale = 1;
	halign = fa_left;
	color = c_white;
	outline_color = o_col;
	outline_width = 2;
}
yy += th;


//extra effects

//miner of the month
with(instance_create_depth(-500,h/2-200,depth,obj_sprite))
{
	other.inst_miner = self;
	sprite_index = spr_miner_of_the_month;
	size = 1.6;
	image_angle = -2;
}

//crown
with(instance_create_depth(w/2,-200,depth,obj_sprite))
{
	other.inst_crown = self;
	sprite_index = spr_crown;
	size = 2.5;
}


#endregion
menu_background_index();
instance_create_depth(0,0,0,obj_opening_scene);
window_set_fullscreen(1);
global.room_is_capital = 0;

#region methods

function create_text_title(){
	
	//destroy prev
	if(instance_exists(title_inst))
		instance_destroy(title_inst);
	
	//create new
	with(instance_create_depth(x,display_get_height()/2-200,0,obj_text))
	{
		other.title_inst = self;
		text = "ORBY 2.0";
		scale = 3;
		color = c_white;
		outline_color = get_colors(COLORS.black);
		outline_width = 5;
		outline_double = 0; //1
	}
}
function create_morse_title(){
	
	//destroy prev
	if(instance_exists(title_inst))
		instance_destroy(title_inst);
	
	//create new
	with(instance_create_depth(x,display_get_height()/2-200,0,obj_sprite))
	{
		other.title_inst = self;
		sprite_index = spr_title_morse;
		outline_color = get_colors(COLORS.black);
		size = 0.4;
		outline_width = 5;
	}
}
//call this after loading up to update changes that are need to be made
function update_menu_changes()	
{
	if(got_endings[|ENDINGS.turnover])
	{
		title_inst.spr = spr_title_morse;
		title_inst.text = "    2.0";
	}
	else
	{
		title_inst.spr = -1;
		title_inst.text = "ORBY 2.0";
	}
}
function create_menu_miner(){
	var _x = irandom_range(0,obj_camera.view_w);
	
	with(instance_create_depth(_x,-100,0,obj_miner))
	{
		instance_destroy(my_orb)
		state = MINERS.menu;
	}
}

#endregion

update_menu_changes();
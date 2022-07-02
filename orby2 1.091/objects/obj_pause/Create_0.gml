///@description 

//pause player
if(instance_exists(obj_player))
	obj_player.is_paused = true;

camera_anchor = obj_camera.is_anchored;
obj_camera.is_anchored = true;
obj_music.pause_ost();

//setup vars
var x1 = obj_camera.x
var w = camera_get_view_width(view_current)
depth = DEPTH.ui_base;
return_value = -1 //this value indicates what action to perform. returned from the text objs.
scale = camera_get_view_height(view_camera[0])/768;//obj_camera.zoom_level;

//create pause menu
text_insts = ds_list_create();

//resume
with instance_create_layer(x1+w/2,-1000,"ui",obj_menu_text)
{
	ds_list_add(other.text_insts, self);
	parent = other;
	text = "resume";
	return_value = "resume";
	scale = other.scale;
}

//load
with instance_create_layer(x1+w/2,-1000,"ui",obj_menu_text)
{
	ds_list_add(other.text_insts, self);
	parent = other;
	text = "load game";
	return_value = "load";
	scale = other.scale;
	
		if(!file_exists(global.savefile))
		state = TEXT_STATES.off;
}

//fullscreen
with instance_create_layer(x1+w/2,-1000,"ui",obj_menu_text)
{
	ds_list_add(other.text_insts, self);
	parent = other;
	text = "toggle fullscreen";
	return_value = "fullscreen";
	scale = other.scale;
}

//fullscreen
with instance_create_layer(x1+w/2,-1000,"ui",obj_menu_text)
{
	ds_list_add(other.text_insts, self);
	parent = other;
	text = "toggle speedrun mode";
	return_value = "speedrun";
	scale = other.scale;
}

//quit to menu
with instance_create_layer(x1+w/2,-1000,"ui",obj_menu_text)
{
	ds_list_add(other.text_insts, self);
	parent = other;
	text = "quit to menu";
	return_value = "quit";
	scale = other.scale;
}

//quit game
with instance_create_layer(x1+w/2,-1000,"ui",obj_menu_text)
{
	ds_list_add(other.text_insts, self);
	parent = other;
	text = "quit game";
	return_value = "quit game";
	scale = other.scale;
}


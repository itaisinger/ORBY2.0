///@description 
ds_list_destroy(text_insts);

//depause player
if(instance_exists(obj_player))
	obj_player.is_paused = false;
	
//deanchor camera
obj_camera.is_anchored = camera_anchor;

//resume ost
obj_music.resume_ost();
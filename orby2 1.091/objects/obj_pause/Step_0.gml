///@description 
#region update actions

var x1 = obj_camera.x
var y1 = obj_camera.y
var h = camera_get_view_height(view_current)

//fix all positions
draw_set_font(font_message);
var yy = 0;
yy = y1+scale*(h - string_height("resumequit")*ds_list_size(text_insts))/2;
var margin = 10*scale;

for(var i=0; i<ds_list_size(text_insts); i++)
{
	text_insts[|i].ystart = yy;
	text_insts[|i].xstart = x1+window_get_width()/2 - (window_get_width()-camera_get_view_width(view_camera[0]))/2
	yy += margin + string_height(text_insts[|i])*scale;
}

#endregion
#region actions

switch(return_value)
{
	case "resume":
		instance_destroy();
		break;
	
	case "load":
		instance_destroy();
		transition(TRANS_STATES.restart);
		break;
		
	case "load checkpoint":
		instance_destroy();
		transition(TRANS_STATES.load_checkpoint);
		break;
		
	case "fullscreen":	
		window_set_fullscreen(!window_get_fullscreen());
		return_value = "";
		break;
		
	case "speedrun":
	return_value = "";
	with(obj_speedrun) global.speedrun_active = !global.speedrun_active;		
		break;
	
	case "quit":	
		instance_destroy(obj_credits);
		save_runtimes();
		transition(TRANS_STATES.menu);
		break;
		
	case "quit game":
		game_end();
		break;
}

#endregion

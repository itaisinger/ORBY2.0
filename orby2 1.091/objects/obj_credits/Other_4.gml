///@description 
with(obj_player) dead = 1;
follow_inst = instance_create_depth(0,0,depth,obj_follow);
follow_inst.x = camera_get_view_width(view_camera[0])*0.5;
follow_inst.y = camera_get_view_height(view_camera[0])*0.5;

//create text insts

switch(room)
{
	case text_rooms[0]:
	 
	//title
	with instance_create_depth(0,0,depth,obj_text)
	{
		depth = DEPTH.text_top;
		text = "ORBY 2.0";
		font = font_menu;
		scale = 2.5;
		ds_list_add(other.list_text_insts,self);
	}
	
	//ending
	with instance_create_depth(0,0,depth,obj_text)
	{
		depth = DEPTH.text_top;
		text = "ending got: " + other.engding_texts[other.end_index];
		scale = 0.7
		font = font_menu;
		ds_list_add(other.list_text_insts,self);
	}
	
	//time
	with instance_create_depth(0,0,depth,obj_text)
	{
		depth = DEPTH.text_top;
		text = "time: " + obj_speedrun.get_time();
		scale = 0.7;
		font = font_menu;
		ds_list_add(other.list_text_insts,self);
	}
	
	//desctruction alter
	if(end_index == ENDINGS.destruction)
	{
		with(obj_power_plant)
		{
			base_scale = 0;
		}
		instance_create_depth(0,0,0,obj_darkness);
		global.darkness_alpha = 0.6;
	}
	
	break;
	
	/////////////////////
	case text_rooms[1]:
	
	//game by itai singer
	with instance_create_depth(0,0,depth,obj_text)
	{
		depth = DEPTH.text_top;
		text = other.credits_text[1];
		font = font_menu;
		scale = 1;
		ds_list_add(other.list_text_insts,self);
	}
	
	//sountrack by matan koresh
	with instance_create_depth(0,0,depth,obj_text)
	{
		depth = DEPTH.text_top;
		text = other.credits_text[2];
		font = font_menu;
		scale = 1;
		ds_list_add(other.list_text_insts,self);
	}
	
	break;
	
	/////////////////////
	case text_rooms[2]:
	
	//motivational support
	with instance_create_depth(0,0,depth,obj_text)
	{
		depth = DEPTH.text_top;
		text = other.credits_text[3];
		font = font_menu;
		scale = 0.8;
		ds_list_add(other.list_text_insts,self);
	}
	
	//alpha beta testing
	with instance_create_depth(0,0,depth,obj_text)
	{
		depth = DEPTH.text_top;
		text = other.credits_text[4];
		font = font_menu;
		scale = 0.8;
		ds_list_add(other.list_text_insts,self);
	}
	
	break;
	///////////
	case text_rooms[3]:
	
	//thank you
	with instance_create_depth(0,0,depth,obj_text)
	{
		depth = DEPTH.text_top;
		text = other.credits_text[5];
		font = font_menu;
		scale = 0.6;
		ds_list_add(other.list_text_insts,self);
	}
	
	break;
	///////////
}

//update colors
for(var i=0; i<ds_list_size(list_text_insts); i++;)
{
	with(list_text_insts[|i])
	{
		halign = fa_center;
		valign = fa_middle;
		
		color = c_white;
		outline_width = 4;
		
		depth = DEPTH.text_top;
		
		switch(other.end_index)
		{
			case ENDINGS.escape:	outline_color = get_colors(COLORS.purple);	 break;
			case ENDINGS.turnover:	outline_color = get_colors(COLORS.blue);	 break;
			case ENDINGS.obedience: outline_color = get_colors(COLORS.black);	 break;
			case ENDINGS.kinghood:	outline_color = get_colors(COLORS.yellow);	 break;
		}
	}
}
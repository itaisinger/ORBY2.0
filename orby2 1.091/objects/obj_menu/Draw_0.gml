///@description 


//draw morse title
if(got_endings[|ENDINGS.turnover])
{
	
	var m_col = c_white;  
	var o_col = c_black;
	var o_w = 4;
	var _s = 0.3;
	
	if(instance_exists(obj_menu_orb))
	{
		o_col = get_colors(obj_menu_orb.color);
		m_col = get_colors_background(obj_menu_orb.color);
	}

	draw_sprite_ext(spr_title_morse,1,title_inst.x+o_w,title_inst.y,_s,_s,0,o_col,1);	//right
	draw_sprite_ext(spr_title_morse,1,title_inst.x-o_w,title_inst.y,_s,_s,0,o_col,1);	//left
	draw_sprite_ext(spr_title_morse,1,title_inst.x,title_inst.y-o_w,_s,_s,0,o_col,1);	//up
	draw_sprite_ext(spr_title_morse,1,title_inst.x,title_inst.y+o_w,_s,_s,0,o_col,1);	//down
									
	draw_sprite_ext(spr_title_morse,1,title_inst.x,title_inst.y,_s,_s,0,m_col,1);	//main
}
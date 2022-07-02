///@description 
if(obj_game.list_got_endings[|ENDINGS.kinghood]) exit;

with instance_create_depth(x,bbox_top,depth,obj_crown)
{
	vsp = 2;
	hsp = 6;
	
	var anvil = instance_place(x,y,obj_anvil);
	y = anvil.bbox_bottom+sprite_height+1;
}

with instance_create_depth(x,y,depth,obj_player_dead_squashed_v)
{
	sprite_index = spr_capital;
	eyeout_spr = spr_capital_eyeout;
	killer = instance_nearest(x,y,obj_anvil_v);
	min_ys = 0.3;
}

play_sfx(sfx_squash);
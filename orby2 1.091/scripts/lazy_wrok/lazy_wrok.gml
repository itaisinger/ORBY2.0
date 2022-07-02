function update_sprites(){
	if(obj_player.is_capital)
	{
		sprite_index = spr_capital;
		eyeout_spr = spr_capital_eyeout;
	}
	else
	{
		sprite_index = spr_player;
		eyeout_spr = spr_eyeout;
	}
}
function log(_msg){
	show_debug_message(_msg);
}

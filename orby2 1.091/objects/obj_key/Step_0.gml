///@description 
if(place_meeting(x,y-1*sign(image_yscale),obj_player) and !pressed)
{
	pressed = 1;
	obj_game.list_pressed_keys[|index] = 1;
	play_sfx(sfx_press);
}

if(wait>0) wait--;
if(pressed)
{
	sprite_index = spr_key_pressed;
	
	if(effect_a > 0)
	{
		if(wait>0) effect_a = 0;
		effect_a -= 0.05;
		effect_yscale += 0.05;
	}
}
else sprite_index = spr_key;
depth = DEPTH.pickup;
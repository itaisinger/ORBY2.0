//press if savepoint is picked
if(ds_list_find_index(obj_orb.list_savepoints,creation_num) != -1)
	pressed = 1;

//press
var xcol = sign(image_xscale)*(image_angle != 0)
var ycol = sign(image_yscale)*(image_angle == 0)
if(place_meeting(x+xcol,y-ycol,obj_player) and !pressed)
{
	play_sfx(sfx_pickup);
	pressed = 1;
	ds_list_add(obj_orb.list_savepoints,creation_num);
	save_savepoints();
	obj_player.draw_xs = 1.5;
	obj_player.draw_ys = 1.5;
}

//visuals
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
else sprite_index = spr_button_pickup;
depth = DEPTH.pickup;
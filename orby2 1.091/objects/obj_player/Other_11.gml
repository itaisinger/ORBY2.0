///@description dying
dead = true;

var body = instance_create_depth(x,y,depth,obj_player_dead);
body.anchor = killer.anchor;
body.killer = killer;
var eye = instance_create_depth(x+eye_xoff,y-sprite_height/2+eye_yoff,depth,obj_player_eye);
eye.image_xscale = eye_dir;
eye.hsp = eye_hsp;
eye.vsp = eye_vsp;

if(is_capital)
{
	body.sprite_index = spr_capital;
	body.eyeout_spr = spr_capital_eyeout;
	eye.sprite_index = spr_capital_eye;
}

if(killer.object_index == obj_power_plant)
{
	instance_destroy(body);
	instance_destroy(eye);
	has_control = 0;
}
lose_anvil();

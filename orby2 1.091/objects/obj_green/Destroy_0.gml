///@description 
if(killer != noone and killer.object_index == obj_power_plant)
{
	instance_destroy(obj_player_eye);
	exit;
}
if(instance_exists(obj_player_eye)) exit;
var eye = instance_create_depth(x+eye_xoff,y-sprite_height/2+eye_yoff,depth,obj_player_eye);
eye.image_xscale = dir;
eye.hsp = hsp;
eye.vsp = vsp;
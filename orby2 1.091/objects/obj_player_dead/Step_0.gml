///@description 
if(instance_exists(obj_pause)) exit;
if(!obj_player.dead) follow_active = false;

//create the optimal player dead obj
var new_inst = noone;
switch(object_get_name(killer.object_index))
{
	case "obj_anvil_v": 
		new_inst = instance_create_depth(x,y,depth,obj_player_dead_squashed_v);
		new_inst.killer = killer;
		new_inst.follow_active = follow_active;
		new_inst.sprite_index = sprite_index;
		new_inst.eyeout_spr = eyeout_spr;
	break;
	
	case "obj_anvil_h": 
		new_inst = instance_create_depth(x,y,depth,obj_player_dead_squashed_h);
		new_inst.killer = killer;
		new_inst.follow_active = follow_active;
		new_inst.sprite_index = sprite_index;
		new_inst.eyeout_spr = eyeout_spr;
	break;
	
	default:
		new_inst = instance_create_depth(x,y,depth,obj_player_dead_spikes);
		new_inst.killer = killer;
		new_inst.follow_active = follow_active;
		new_inst.sprite_index = sprite_index;
		new_inst.eyeout_spr = eyeout_spr;
}

instance_destroy();

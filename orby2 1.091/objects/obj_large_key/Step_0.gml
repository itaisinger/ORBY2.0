var anvils = obj_game.list_placed_anvils;
var inst = noone;

//deactivate the anvils i already know
for(var i=0; i<ds_list_size(anvils); i++)
{
	//loop through all the anvils in the room
	//and look for the one in the list that is standing on me
	for(var j=0; j<instance_number(obj_anvil_pickup); j++)
	{
		if(instance_find(obj_anvil_pickup,j).creation_num == anvils[|i])
			inst = instance_find(obj_anvil_pickup,j);
	}
	
	//if he is not in the room, create him and place him.
	if(inst == noone) 
	{
		inst = instance_create_depth(0,bbox_top-1,depth,obj_anvil_pickup);
		inst.creation_num = anvils[|i];
	}
	
	//place the anvil and deactivate him to allow collision check later
	inst.placed = true;
	inst.x = obj_game.list_placed_anvils_x[|ds_list_find_index(anvils,inst.creation_num)];
	instance_deactivate_object(inst);
	inst = noone;
}

//check for a new anvil
inst = instance_place(x,y-1,obj_anvil_pickup)
if(inst != noone and ds_list_size(anvils)<4)
{
	inst.placed = true;
	ds_list_add(anvils,inst.creation_num);
	ds_list_add(obj_game.list_placed_anvils_x,inst.x);
}
instance_activate_all();

var player_standing = 0;
if(instance_exists(obj_player))
	player_standing = place_meeting(x,y-1,obj_player) and obj_player.anvil_index != -1;
	
image_yscale = lerp(image_yscale,(base_h/4)*(4-ds_list_size(anvils)-player_standing+0.2),0.05);


if(!mouse_check_button_pressed(mb_left)) exit;
if(y != yprevious) exit;
if(instance_exists(obj_orb)) exit;

with instance_create_depth(x,y,depth,obj_orb)
{
	state_anim = ORB_ANIMS.create;
	spd_max = 0;
}

image_index++; 
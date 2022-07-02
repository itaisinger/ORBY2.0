if(instance_exists(obj_orb)) instance_destroy();

yoff = 0;
state = 0;
scale = 0.7;
spd = 2;
dir = 0;
r = 0;

sprite_index = spr_orb_create;
cnt = 0;
depth = DEPTH.orb_unlock;

enum ORB_CREATE_STATES{
	natural,
	spin1,
	spin2,
	create,
	create2,
	_end,
}
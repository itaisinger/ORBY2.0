index = COLORS.purple;
creation_num = room;

sprite_index = spr_unlock

yoff = 0;
state = 0;
scale = 0.7;
spd = 16;
spd_min = 3.7;
fly_spd = 0;
dir = 0;

cnt = 0;
depth = DEPTH.orb_unlock;

if(global_get_orb_picked(creation_num))
	state = UNLOCK_STATES.off;

enum UNLOCK_STATES{
	natural,
	spin1,
	spin2,
	pause,
	fly,
	off,
}

enum UNLOCK_SCALE{
	base = 0.7,
}

